alias ll='ls -la'

PROJECT_REPO=/home/nav-dev/repo
PROJECT_BUILD=/home/nav-dev/build
PROJECT_CONF=/home/nav-dev/conf
PROJECT_DATA=/home/nav-dev/data

# -----> KISIO DIGITAL <-----

NAVITIA_REPO=$PROJECT_REPO/navitia
NAVITIA_BUILD=$PROJECT_BUILD/navitia

# Update Python virtual environment
navitia_env_update() {
    rmvirtualenv nav-py2
    mkvirtualenv -p /usr/bin/python2 nav-py2
    pip install -r $NAVITIA_REPO/source/eitri/requirements.txt
    pip install -r $NAVITIA_REPO/source/cities/requirements.txt
    pip install -r $NAVITIA_REPO/source/tyr/requirements_dev.txt
    pip install -r $NAVITIA_REPO/source/monitor/requirements.txt
    pip install -r $NAVITIA_REPO/source/jormungandr/requirements_dev.txt
    pip install -r $NAVITIA_REPO/source/sql/requirements.txt
}

alias eitri='$NAVITIA_REPO/source/eitri/eitri.py -e $NAVITIA_BUILD/ed/'
alias kraken='$NAVITIA_BUILD/kraken/kraken $PROJECT_CONF/kraken/kraken.ini'
alias jormungandr='cd $NAVITIA_REPO/source/jormungandr && PYTHONPATH=$NAVITIA_REPO/source/navitiacommon JORMUNGANDR_INSTANCES_DIR=$PROJECT_CONF/jormungandr JORMUNGANDR_START_MONITORING_THREAD=False JORMUNGANDR_DISABLE_DATABASE=True JORMUNGANDR_IS_PUBLIC=True FLASK_APP=jormungandr:app flask run'

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
workon nav-py2
