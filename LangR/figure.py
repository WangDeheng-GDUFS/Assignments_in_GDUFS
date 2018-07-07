import pandas
from matplotlib import pyplot

# gdp = pandas.read_csv('./gdp.csv', header=0)
# pyplot.figure(figsize=(15, 10))
# pyplot.title("GDP")
# x = [2010, 2011, 2012, 2013, 2014, 2015, 2016]
# for index in gdp.index:
#     row = list(gdp.loc[index].values[:])
#     pyplot.plot(x, row[1:], label=row[0])
# pyplot.legend()
# # pyplot.show()
# pyplot.savefig('figures/' + "GDP" + '.png', format='png')
# pyplot.close('all')


# gdp_rate = pandas.read_csv('./gdp_rate.csv', header=0)
# pyplot.figure(figsize=(15, 10))
# pyplot.title("GDP_Rate")
# x = [2011, 2012, 2013, 2014, 2015, 2016]
# for index in gdp_rate.index:
#     row = list(gdp_rate.loc[index].values[:])
#     pyplot.plot(x, row[2:], label=row[1])
# pyplot.legend()
# # pyplot.show()
# pyplot.savefig('figures/' + "GDP_Rate" + '.png', format='png')
# pyplot.close('all')


the_third = pandas.read_csv("./The_Third.csv", header=0)
pyplot.figure(figsize=(15, 10))
pyplot.title("The_Third")
x = [2010, 2011, 2012, 2013, 2014, 2015, 2016]
for index in the_third.index:
    row = list(the_third.loc[index].values[:])
    pyplot.plot(x, row[2:], label=row[1])
pyplot.legend()
# pyplot.show()
pyplot.savefig('figures/' + "The_Third" + '.png', format='png')
pyplot.close('all')
