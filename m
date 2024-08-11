units lj
atom_style atomic
dimension 3
boundary p p p

lattice	sc 0.6
region	box block 0 10 0 10 0 10
create_box	1 box
create_atoms 	1 box

#define interparticle interactions
pair_style lj/cut 3.5 #at 3.5 sigmas lj potential stops calculating it gets cutoff
pair_modify shift yes#atoms of type 1 will interact with atoms of type one having diameter1.0 and energy1.0
pair_coeff * * 1.0 1.0
mass	1 1.0

#defining neigbour list(every particle will consider neihbours witin 2.8 distance) neighbour list is calculated each time step
neighbor 0.3 bin
neigh_modify delay 10 every 1 #every 10 seconds the sim will rebuild itlself

#define simulation parameters
fix LinMom all momentum 50 linear 1 1 1 angular#(every 50 timestep the box momentum is rezeroed)
fix 1 all nvt temp 1.00 1.00 5.0#(twmp command acting as thermostat)
#fix 2 all npt temp 1.00 1.00 25 iso 1.515 1.515 10

#final setup 1.Define statring particle velocity , 2.define timestep 3.define output system properties[temp,energy etc]
velocity all create 1.0 199085  mom no 
timestep 0.005

thermo_style custom step temp etotal pe ke press vol density
thermo 500

run_style verlet

run 50000
