# Digital-Signal-Processing-2
This repository contains MATLAB files for Digital Signal Processing (DSP). These files are intended to be used as educational and reference material for anyone learning about DSP or working on DSP projects.

Getting Started
To use these files, you should have MATLAB installed on your computer. You can download a free trial version of MATLAB from the MathWorks website.

Once you have MATLAB installed, simply clone or download this repository to your computer. You can then open the MATLAB files in MATLAB and run them.

## Contents
The repository contains the following MATLAB files:

**auto_corrs.m** : A demo of generating an auto correlation matrix.

**cross_corre.m** : A demo of generating cross correlation vector bewtween two random vectors.

**Lab1.m** : A demo of generating the ***wiener filter*** optimum weights and the and the corresponding minimzed mean square error **Jmin** . the file shows how to generate random signals **d(n)** and **u(n)**, then inputs **u(n)** into the wiener filter  . the weiener filter tries to match between the input signal **u(n)** and the desired signal **d(n)** by reducing the MSE **Jmin** 

**wiener.m** : just a representation of Lab1 as function to be used in general.

**Lab2.m** : A demo of generating the wiener filter optimum weights and the and the corresponding minimzed mean square error **Jmin** by **Gradient descent** algorithm instead of the **wiener** method. 

**Gradient.m** : just a representation of Lab2 as function to be used in general.
