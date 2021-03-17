
#%%
import numpy as np
import matplotlib.pyplot as plt


# %%

# %%

# %%
a
# %%


plt.hist([c,d])
# %%
# Daten aus Destatis Datenblatt rauskopiert
# Originaldatei: destatis.csv
fem = np.array([1441, 1795 ,2014, 2279, 2435, 2751, 3120, 3093, 3260, 3487])
ges = np.array([10345, 12985, 13205, 14051 ,14653, 15858, 17175, 17483, 18142, 18586])

years = []
tics = range(0,10)
for y in range(2010,2020):
    years.append(str(y))

y_perc = np.arange(0,0.2,0.01)

# %%
fig, ax = plt.subplots(figsize=(12, 6))
ax.plot(fem/ges,lw=5,c='black')
plt.xticks(tics, years)

plt.ylim([0,0.5])
plt.yticks([0.1,0.2,0.3,0.4,0.5],['10%','20%','30%','40%','50%'])
plt.savefig("percent_freshwomen")
# %%
fem/ges
# %%
geeignet_pre = [6, 5, 2, 5, 6, 4 ,5 ,3, 2, 1, 4, 4, 2, 3, 5, 5, 5, 5, 3, 4, 2 ,5 ,4 ,4 ,1 ,
6, 3, 5, 6, 4, 3, 3, 3, 3, 3, 4, 5, 5, 2, 6, 5, 4]
geeignet_post = [3, 6, 2, 3, 6, 3, 3, 2, 1, 1, 4, 3, 2, 1, 2, 5, 2, 3, 2, 2, 2 ,3, 2, 3, 1,
 5, 2, 2 ,2 ,3, 2, 1, 1, 2, 3, 3 ,3 ,3 ,2 ,5, 3, 4]
# %%
plt.hist([geeignet_pre,geeignet_post], color=["grey", "black"], align='mid', range=(1,7),
label=["pre","post"])
# %%
