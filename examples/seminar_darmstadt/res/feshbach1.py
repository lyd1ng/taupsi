'''
Create a plot of the scattering length pole 
'''
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.rcParams['lines.linewidth'] = 2
mpl.rcParams['axes.labelsize'] = 20
mpl.rcParams['legend.fontsize'] = 12

def morse(R, De, Rm, beta, offset):
    return De * (1 - np.exp(-beta * (R - Rm)))**2 - De + offset

if __name__ == "__main__":
    xs = np.linspace(1.7, 8, 128)
    ys1 = morse(xs, 7, 2.5, 1, 0)
    ys2 = morse(xs, 5, 2.5, 1, 0.5)
    plt.plot(xs, ys1, color='black', label="Open Channel")
    plt.plot(xs, ys2, color='red', label="Closed Channel")
    plt.xlim(1.6, 8)
    plt.axhline(0.01, 0, 8, color='blue', label="Incident Energy")
    plt.hlines(-0.5, 1.86, 4.74, color='red', ls='--', label="Resonant Bound State")
    plt.xlabel("Internuclear Separation")
    plt.ylabel("Energy")
    plt.xticks([])
    plt.yticks([])
    plt.legend()
    plt.show()
