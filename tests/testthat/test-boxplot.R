library(magmavizR)
library(dplyr)


y <- c(18.0, 15.0, 18.0, 16.0, 17.0, 15.0, 14.0, 14.0, 14.0, 15.0)
x <- c("USA",
       "Europe",
       "Europe",
       "Europe",
       "Japan",
       "Japan",
       "Japan",
       "USA",
       "USA",
       "Europe")

df <- dplyr::tibble('miles_per_gallon' = y,
                    'origin' = x)

plot <- boxplot(df, origin, miles_per_gallon)
plot_facet <- boxplot(df, origin, miles_per_gallon, facet=TRUE)


test_that("The check for input type for x is failing",{
    expect_error(boxplot(df, "origin", miles_per_gallon),
                 "x, the column name for x, must be unquoted")
})


test_that("The check for input type for y is failing",{
    expect_error(boxplot(df, origin, "miles_per_gallon"),
                         "y, the column name of y, must be unquoted")
})


test_that("The check for input type for df is failing",{
    expect_error(boxplot(df$miles_per_gallon, miles_per_gallon, origin),
                 'df must be a dataframe or tibble')
})

test_that("The check for column name for x is failing",{
    expect_error(boxplot(df,origi,miles_per_gallon),
                 'x column name not found')
})


test_that("The check for column name for y is failing",{
    expect_error(boxplot(df,origin,miles_per_gallo),
                 'y column name not found')

})

test_that("Test for the type of x is failing", {
    expect_error(boxplot(df,miles_per_gallon, origin),
                 'x needs to have distinct categories')
})

test_that("Test for the type of y is failing", {
    expect_error(boxplot(df,origin, origin),
                'y needs to be numeric')
})

###output tests

test_that('Test x maps to x-axis and y maps to y_axis', {
expect_true(rlang::get_expr(plot$layers[[1]]$mapping$x)
    == 'origin')
expect_true(rlang::get_expr(plot$layers[[1]]$mapping$y)
        == 'miles_per_gallon')
})

test_that('Facetting is occuring as expected', {
expect_true('FacetWrap' %in% class(rlang::get_expr(plot_facet$facet)))
expect_true('FacetNull' %in% class(rlang::get_expr(plot$facet)))
})



