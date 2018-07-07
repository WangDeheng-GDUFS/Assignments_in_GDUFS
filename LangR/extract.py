import pandas

# gdp = pandas.read_csv('./gdp.csv', header=0)
# gdp_rate = []
# for index in gdp.index:
#     row = list(gdp.loc[index].values[:])
#     for i in range(1, len(row) - 1):
#         row[i] = row[i + 1] / row[i] * 100
#     row = row[0: -1]
#     gdp_rate.append(row)
# pandas.DataFrame(gdp_rate).to_csv(
#     './gdp_rate.csv', header=['City', '2011', '2012', '2013', '2014', '2015', '2016']
# )

the_third = pandas.read_excel("./02-18.xls", skiprows=4, header=0)
the_third.drop(0, axis=0, inplace=True)
the_third.drop("市  别", axis=1, inplace=True)
the_third.drop(2000, axis=1, inplace=True)
the_third.drop(2005, axis=1, inplace=True)
the_third.to_csv("./The_Third.csv", header=0)
