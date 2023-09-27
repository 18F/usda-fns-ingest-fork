# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9.18

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install pip requirements
COPY usda_fns_ingestor/requirements.txt /app
RUN pip install -r requirements.txt --no-cache-dir
COPY . /app

WORKDIR /app/usda_fns_ingestor/

# I am running this manually for now
# RUN python manage.py migrate --noinput --settings=usda_fns_ingestor.settings.local

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000", "--settings=usda_fns_ingestor.settings.local"]
