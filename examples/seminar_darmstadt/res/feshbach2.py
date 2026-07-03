'''
Create a plot of the scattering length pole 
'''
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.rcParams['lines.linewidth'] = 2
mpl.rcParams['axes.labelsize'] = 20
mpl.rcParams['legend.fontsize'] = 12

def pole(b_field, pos, off_resonance_value, strength):
    return off_resonance_value + strength / (1 - np.exp(b_field - pos))

if __name__ == "__main__":
    xs1 = np.linspace(1.9, 1.99, 128)
    xs2 = np.linspace(2.01, 2.1, 128)
    ys1 = pole(xs1, 2, 10, 1)
    ys2 = pole(xs2, 2, 10, 1)
    plt.ylim(-100, 100)
    plt.xlim(1.9, 2.1) 
    plt.xticks([])
    plt.yticks([])
    plt.xlabel("External Magnetic Field")
    plt.ylabel("Scattering Length")
    plt.plot(xs1, ys1, color='red')
    plt.plot(xs2, ys2, color='red')
    plt.axvline(2, color='black', ls='--')
    plt.axhline(10, color='black', ls='--')
    plt.show()
