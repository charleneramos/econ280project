import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_excel('/Users/crramos/OneDrive - UC San Diego/Documents/UC San Diego/ECON 280 Computation/econ280project/code/02_analysis/df.xlsx')

plt.figure(figsize=(10, 6))
plt.plot(df['Decades'], df['log2(IdeaTFP)'], color='navy', linewidth=3)
plt.ylim(-6.01, 0)
plt.yticks(np.arange(-6, 1, 1), labels=['1/64', '1/32', '1/16', '1/8', '1/4', '1/2', '1'])
plt.text(1960, -1.5, "Effective number of\n researchers (right scale)", color="black", fontsize=10)
plt.ylabel('Index (1930=1)', color='navy', fontsize=12)

# add right axis
ax2 = plt.gca().twinx()
ax2.plot(df['Decades'], df['log2(Scientists)'], color='forestgreen', linewidth=3)
ax2.set_ylim(0, 5)
ax2.set_yticks(np.arange(0, 6, 1))
ax2.set_yticklabels(['1', '2', '4', '8', '16', '32'])
ax2.text(1975, 1.75, "Research productivity\n (left scale)", color="black", fontsize=10)
ax2.set_ylabel('Index (1930=1)', color='forestgreen', fontsize=12)

# add x-axis
plt.xticks(df['Decades'], labels=['1930s', '1940s', '1950s', '1960s', '1970s', '1980s', '1990s', '2000s'])
plt.xlim(df['Decades'].min(), df['Decades'].max())

# save png
plt.tight_layout()
plt.savefig('/Users/crramos/OneDrive - UC San Diego/Documents/UC San Diego/ECON 280 Computation/econ280project/output/main_result_python.png')
plt.show()
