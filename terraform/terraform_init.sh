# check env
mode=plan

account=`aws sts get-caller-identity | grep Account`
echo ${account} | grep Account > /dev/null 2>&1
if [ "$?" -ne 0 ]
then
  echo 'Please use aws vault to login to AWS Account'
  exit 0
fi

echo ${account} | grep 816905787311 > /dev/null 2>&1
if [ "$?" -ne  0 ]
then
  echo "${account} is not valid to log into dev environment. Please use 816905787311"
  exit 0
fi

# build for all envs
terraform init -backend-config="bucket=cbp-tfstate" -backend-config="region=us-east-1" -backend-config="key=selenium_grid_state"
set +e
terraform workspace new selenium.dev.us-east-1
set -e
terraform workspace select selenium.dev.us-east-1

case $1 in
  plan) mode="plan"
  ;;
  auto-approve) mode="apply -auto-approve"
  ;;
  *) mode="apply"
  ;;
esac
terraform ${mode}
