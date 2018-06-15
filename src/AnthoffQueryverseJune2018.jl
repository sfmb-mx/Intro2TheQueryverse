
using Queryverse, VegaDatasets, IndexedTables

cars = dataset("cars")

cars |> Voyager()

cars |>
@filter(_.Origin=="USA")

cars |>
@filter(_.Origin=="USA") |>
save("us_cars.csv")

load("us_cars.csv") |>
@vlplot(:point, x=:Miles_per_Gallon, y=:Weight_in_lbs, color="Cylinders:n")

load("data/cars.csv")

load("data/cars.feather")

load("data/cars.xlsx", "cars")

load("data/cars.xlsx", "cars!C1:G41")

load("data/cars.dta")

load("data/cars.sas7bdat")

load("data/cars.sav")

cars

save("cars1.csv", cars)

cars |> save("cars2.csv")

cars |> save("cars3.csv", delim=';')

cars |> save("cars4.feather")

load("data/cars.sas7bdat") |> save("cars5.csv")

load("data/cars.csv") |> typeof

load("data/cars.feather") |> typeof

dataset("cars") |> typeof

DataFrame(load("data/cars.feather"))

load("data/cars.feather") |> DataFrame

load("data/cars.feather") |> table

load("data/cars.feather") |> table |> DataFrame

load("data/cars.feather") |> DataFrame |> table

load("data/cars.feather") |> DataFrame |> @vlplot(:point, x=:Horsepower, y=:Acceleration)

load("data/cars.feather") |> table |> @vlplot(:point, x=:Horsepower, y=:Acceleration)

load("data/cars.feather") |> @vlplot(:point, x=:Horsepower, y=:Acceleration)

it = load("data/cars.sas7bdat") |> table

df = it |> DataFrame

it |> Voyager()

df |> Voyager()

it |> save("cars8.feather")

df |> save("cars9.feather")

load("data/cars.csv") |> @filter(_.Origin=="Europe") |> DataFrame

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    DataFrame

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    save("cars10.csv")

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    @tee(save("cars10.csv"))

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    @tee(save("cars10.csv")) |>
    @vlplot(:point, x=:Acceleration, y=:Horsepower)

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    @tee(save("cars10.csv")) |>
    @vlplot(:point, x=:Acceleration, y=:Horsepower) |>
    save("fig1.png")

load("data/cars.csv") |>
    @filter(_.Origin=="Europe") |>
    @tee(save("cars10.csv")) |>
    @vlplot(:point, x=:Acceleration, y=:Horsepower) |>
    @tee(save("fig1.png")) |>
    @tee(save("fig1.pdf"))

load("data/cars.feather") |> @filter(_.Origin=="Europe") |> @orderby(_.Horsepower)

1:8 |> @filter(_%2==0) |> @orderby_descending(_)

1:8 |> @filter(_%2==0) |> @orderby_descending(_) |> collect

Dict(:a=>4, :b=>2, :c=>8)

Dict(:a=>4, :b=>2, :c=>8) |> @filter(_[2]>3)

Dict(:a=>4, :b=>2, :c=>8) |> @filter(_[2]>3) |> collect

Dict(:a=>4, :b=>2, :c=>8) |> @filter(_[2]>3) |> Dict

(i=>i^2 for i in 1:10) |> @filter(_[2]>3) |> @orderby(_[1]) |> collect

1:10 |> @filter(_>5)

1:10 |> @filter(i -> i>5)

1:10 |> @map(_^2)

1:10 |> @map(_=>_^2) |> Dict

cars |> @map(_.Origin)

r = cars |> collect

nt = r[1]

typeof(nt)

fieldnames(nt)

nt.Origin

nt[3]

cars |> @map(_.Origin)

1:10 |> @map({foo=_, bar=_^2})

cars

cars |> @map({_.Name, _.Year})

cars |> @map({_.Name, Foo=_.Year})

cars |> @map({_.Name, Foo=_.Year}) |> save("cars11.csv")

cars |> @map(_.Name => Date(_.Year)) |> Dict

1:10 |> @drop(3)

1:10 |> @drop(3) |> @take(4)

cars |> @drop(3) |> @take(4)

cars |> @orderby(_.Origin)

cars |> @orderby_descending(_.Origin)

cars |> @orderby(_.Origin) |> @thenby(_.Year)

cars |> @orderby(_.Origin) |> @thenby(_.Year) |> @thenby_descending(_.Horsepower)

cars |> @orderby(length(_.Origin))

cars |> @groupby(_.Origin)

cars |> @groupby(_.Origin) |> @map(_.key)

cars |> @groupby(_.Origin) |> @map(length(_))

cars |> @groupby(_.Origin) |> @map(_[3])

cars |> @groupby(_.Origin) |> @map({Origin=_.key, Count=length(_)})

cars |> @groupby(length(_.Origin)) |> @map({OriginLength=_.key, Count=length(_)})

cars |> @groupby(_.Origin, _.Acceleration) |> @map({Origin=_.key, MeanAcceleration=mean(_)})

cars |> @groupby(_.Origin) |> @map({Origin=_.key, MeanAcceleration=mean(_..Acceleration)})

region_stats = cars |>
    @groupby(_.Origin) |>
    @map({
        Region=_.key,
        MeanAcceleration=mean(_..Acceleration),
        MinCylinders=minimum(_..Cylinders)
    })

cars

region_stats

cars |>
    @join(region_stats, _.Origin, _.Region, {_.Name, reg_ex_acc=_.Acceleration - __.MeanAcceleration}) |>
    @orderby_descending(_.reg_ex_acc)

q = load("data/cars.feather") |>
    @filter(_.Origin=="USA") |>
    @map({_.Name, _.Cylinders}) |>
    @take(5);

for row in q
    println(row)
end

load("data/cars.feather") |>
    @filter(_.Origin=="USA") |>
    @map({_.Name, _.Cylinders}) |>
    save("cars12.csv")

cars

cars |> @vlplot(:point)

cars |> @vlplot(:point, x=:Miles_per_Gallon)

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration)

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, color=:Origin)

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, column=:Origin, color=:Cylinders)

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, column=:Origin, color="Cylinders:n")

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, column=:Origin, color="Cylinders:o")

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, shape=:Origin, color="Cylinders:o")

cars |> @vlplot(:point, x=:Miles_per_Gallon, y=:Acceleration, shape=:Origin, color="Cylinders:o", height=300, width=300)

cars |> @vlplot(:bar, x={:Miles_per_Gallon, bin=true}, y="count()")

cars |> @vlplot(:bar, x={:Miles_per_Gallon, bin=true}, y="count()", column=:Origin)

readdir() |> @groupby(length(_)) |> @map({length=_.key, count=length(_)}) |> @vlplot(:bar, x=:count, y="length:o")

p = cars |> @vlplot(:bar, x={:Miles_per_Gallon, bin=true}, y="count()", column=:Origin)

typeof(p)

p |> save("foo.png")

p |> save("foo.pdf")

p |> save("foo.svg")

p |> save("foo.eps")

p |> save("foo.vegalite")

v = cars |> Voyager

v[]

typeof(v[])

v[] |> save("foo2.pdf")

v[] |> save("foo.vegalite")

load("foo.vegalite")

cars |>
    @filter(_.Origin in ("USA", "Japan")) |>
    load("foo.vegalite")
