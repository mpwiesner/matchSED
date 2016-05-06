This package uses the lsst/sims_photUtils package in order to match a set of galaxy magnitudes to an SED. 

First, you should install the DMStack.  I recommend using Anaconda.  If you have Anaconda, follow instructions here:

https://gist.github.com/mjuric/1e097f2781bc503954c6

Next, initialize the lsst_sims package using these commands:

source eups-setups.sh
setup lsst_sims 

Next run my code to call the selectGalaxySED package, using this command:

python matcher.py

You will then get a list of SEDs chosen by selectGalaxySED written to the file 'SEDmatch.out'

Then open IDL and run SEDplot.pro using this code:

IDL
.compile SEDplot.pro
SEDplot

It will give you flux densities corresponding to each magnitude and will plot these against each SED.