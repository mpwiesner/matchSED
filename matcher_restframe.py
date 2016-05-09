from lsst.sims.photUtils.selectGalaxySED import selectGalaxySED
import os
import numpy as np
import lsst.utils
from lsst.sims.photUtils.BandpassDict import BandpassDict

#If you are using your own folder this should be selectGalaxySED(galDir = yourFolder)
matchSED = selectGalaxySED()
"""Can restrict the loading below to a subset of the SEDs in a given folder if you pass a list
as matchSED.loadBC03(subset = subsetList)"""
sedList = matchSED.loadBC03()

print sedList[1].wavelen
print sedList[1].flambda
print sedList[1].name

#Import sample galaxy catalog organized as [RA, Dec, z, mag_g, mag_r, mag_i, mag_z, mag_y]
ra, dec, z, mag_g, mag_r, mag_i, mag_z, mag_y = np.genfromtxt('sampleGalCat.dat', unpack=True)

"""Organize magnitudes into single array with each row corresponding to the 
set of magnitudes of one object"""
catMags = np.transpose([mag_g, mag_r, mag_i, mag_z, mag_y])

#Define bandpasses. This example shows loading in LSST grizy bandpasses.
galBandpassDict = BandpassDict.loadTotalBandpassesFromFiles(['g', 'r', 'i', 'z', 'y'])

#We'll need to set makeCopy to True since we are going to reuse this sedList below
#matchObservedNames, matchObsMagNorm, matchObsErrors = matchSED.matchToObserved(sedList, catMagsObs, z, catRA=ra, catDec=dec, 
#                                                                               bandpassDict = galBandpassDict, dzAcc=2,extCoeffs = (3.0999999,3.0999999,3.0999999,3.0999999,3.0999999,3.0999999))  #(4.145, 3.237, 2.273, 1.684, 1.323, 1.088))

matchRestFrameNames, matchRestMagNorm, matchErrors = matchSED.matchToRestFrame(sedList, catMags, 
                                                                               bandpassDict = galBandpassDict,
                                                                               makeCopy = True)
#Show the resulting matches
#print matchObservedNames
#print matchObsMagNorm
#print matchObsErrors

print matchRestFrameNames
print matchRestMagNorm
print matchErrors

phile = open("matchSED.out","w")

for h in range (0, len(matchRestFrameNames)):
	print >>phile, matchRestFrameNames[h][:-3]