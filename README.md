# usda-fns-ingestor

An experiment in ingesting data for the USDA's Food and Nutrition Service
using [ReVAL](https://github.com/18F/ReVAL-fork).

Use [the webform](https://usda-fns-ingestor.app.cloud.gov/data_ingest/api/validate/)
to interactively upload files and see
validation results, or the [API](api.md) to simply see the validation results.

## Development

To start development, clone this repository:

	git clone https://github.com/18F/usda-fns-ingest-fork.git

Copy `.env_sample` to `.env` and update the variables according to cloud.gov `env`.

In your terminal run:
```
Docker compose up
```
While that is running in a new tab run the migrations
```
docker exec -it usda-fns-ingest-usdafnsingest-1 /bin/bash
# python manage.py migrate

```
Run the tests wih:
```
# pip install parameterized
# python manage.py tests
```
Create a user to test via the web app:
```
# python manage.py createsuperuser
```
Follow the prompts to create a username and password for local testing

This tool makes use of the [ReVAL](https://github.com/18F/ReVAL) tool, if you also are developing that tool at the same time, you will need to have a local copy of it.  You can then install and point to the local copy so the changes you make there will reflect on this tool immediately.

	pipenv install -d -e <path to ReVAL>

Then you can access the system at
[http://localhost:8000/data_ingest/](http://localhost:8000/data_ingest/)

## Deploying to cloud.gov

Once [logged into a cloud.gov workspace](https://cloud.gov/docs/apps/deployment/),
you can

    cd usda_fns_ingestor
    cf create-service aws-rds micro-psql usda-fns-ingestor-db
    cf push

Other CloudFoundry platforms and Heroku should work similarly,
though different plans may be available (see `cf marketplace`)

## Deploy to cloud.gov with GitHub Actions
(Only implemented in dev from the 18F account)
Per environment set up a deployment key using a [service account](https://cloud.gov/docs/services/cloud-gov-service-account/).

    cf create-service cloud-gov-service-account space-deployer fns-service-account
    cf create-service-key fns-service-account fns-service-key
    cf service-key fns-service-account fns-service-key

That will give you credentials for GitHub. In the FNS Ingest repo, go to settings:
 - Add branch protections to the main branch so that only the users that can deploy can merge to the main branch and add version tags.
 - Go to Environments
 - Create the environments: dev, staging and prod if they don't already exist
 - In the respective environment add
    - `CF_USERNAME`
    - `CF_PASSWORD`

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md) for additional information.

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
