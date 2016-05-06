pro SEDplot

;SETUP STUFF
A = FINDGEN(17) * (!PI*2/16.)  
USERSYM, COS(A), SIN(A), /FILL  
;set_plot, 'PS'
set_plot, 'X'
simpctable
!p.multi=[0,1,1,0,0]
device, retain=2

rdfloat, 'sampleGalCat.dat', ra, dec, redshift, g1, r1, i1, z1, y1, /DOUBLE, skipline=1

readcol, 'matchSED.out', name, format='a0'

stan_l=findgen(5)
;stan_l[0]=359.0
stan_l[0]=481.0
stan_l[1]=623.0
stan_l[2]=764.0
stan_l[3]=906.0
stan_l[4]=990.0

for k=0, N_ELEMENTS(g1)-1 do begin   ;<---THIS LOOPS THROUGH ALL GALAXIES

rdfloat, 'SEDs/'+name[k], A1, intt, skipline=1

;	u=u1[k]
	g=g1[k]
	r=r1[k]
	i=i1[k]
	z=z1[k]
	y=y1[k]

	;CONVERT MAGNITUDES TO FLUXES
	;---------------------------------------------------------------------------
	;based on http://ned.ipac.caltech.edu/help/sdss/dr6/photometry.html#asinh

;	Fu=3631*(10E-24)*((8.36E14)/3590.) 
	Fg=3631*(10E-24)*((6.24E14)/4810.) 
	Fr=3631*(10E-24)*((4.82E14)/6230.) 
	Fi=3631*(10E-24)*((3.93E14)/7640.) 
	Fz=3631*(10E-24)*((3.31E14)/9060.) 
	Fy=3631*(10E-24)*((3.030E14)/9900.) 

;	f_u=10^(u/(-2.5))*Fu
	f_g=10^(g/(-2.5))*Fg
	f_r=10^(r/(-2.5))*Fr
	f_i=10^(i/(-2.5))*Fi
	f_z=10^(z/(-2.5))*Fz
	f_y=10^(y/(-2.5))*Fy

	stan_f=findgen(5)
;	stan_f[0]=f_u
	stan_f[0]=f_g
	stan_f[1]=f_r
	stan_f[2]=f_i
	stan_f[3]=f_z
	stan_f[4]=f_y

;	print, 'f_u', f_u
;	print, 'mag_u', u
	print, 'f_g', f_g
	print, 'mag_g', g
	print, 'f_r', f_r
	print, 'mag_r', r
	print, 'f_i', f_i
	print, 'mag_i', i
	print, 'f_z', f_z
	print, 'mag_z', z
	print, 'f_y', f_y
	print, 'mag_y', y

	wait, 1.0

plot, A1, intt, psym=8, xrange=[0,1100], xtitle='Wavelength (nm)', ytitle='ergs cm!E-2!N s!E-1!N A!E!N', yrange=[0,2]

TVLCT, 0, 0, 255, 100

;oplot, A1, intt, psym=8, color=100

wave_diff=ABS(A1-481.0)

fine=where(wave_diff EQ min(wave_diff))

intt1=intt[fine]

factor=intt1/f_g

;factor=10.^(-17.)

print, 'factor', factor

stan_lee=findgen(5)

;delta_u=ABS(A1-359.0)
delta_g=ABS(A1-481.0)
delta_r=ABS(A1-623.0)
delta_i=ABS(A1-764.0)
delta_z=ABS(A1-906.0)
delta_y=ABS(A1-990.0)

;u_fine=where(delta_u EQ min(delta_u))
g_fine=where(delta_g EQ min(delta_g))
r_fine=where(delta_r EQ min(delta_r))
i_fine=where(delta_i EQ min(delta_i))
z_fine=where(delta_z EQ min(delta_z))
y_fine=where(delta_y EQ min(delta_y) AND A LE 990.0)

;stan_lee[0]=stan_f[0]*factor
stan_lee[0]=stan_f[0]*factor
stan_lee[1]=stan_f[1]*factor
stan_lee[2]=stan_f[2]*factor
stan_lee[3]=stan_f[3]*factor
stan_lee[4]=stan_f[4]*factor

TVLCT, 0, 0, 255, 100
oplot, stan_l, (stan_lee), psym=8, color=100, symsize=4 

endfor

end