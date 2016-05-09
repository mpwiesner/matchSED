This package uses the lsst/sims_photUtils package in order to match a set of galaxy magnitudes to an SED. 

First, you should install the DMStack.  I recommend using Anaconda.  If you don't have Anaconda, download and install it.  
If you have Anaconda, follow instructions here to install DMStack:

https://gist.github.com/mjuric/1e097f2781bc503954c6

Next, initialize the lsst_sims package using these commands:

source eups-setups.sh
setup lsst_sims 

If your input magnitudes are in the rest frame, run this code to call the selectGalaxySED package:

python matcher_restframe.py

If your input magnitudes are as observed at a particular redshift, run this code to call the selectGalaxySED package:

python matcher_redshift.py


Either program will write a list of SEDs chosen by selectGalaxySED to the file 'SEDmatch.out'

Then open IDL and run SEDplot.pro using this code:

IDL
.compile SEDplot.pro
SEDplot

It will give you flux densities corresponding to each magnitude and will plot these against each SED.