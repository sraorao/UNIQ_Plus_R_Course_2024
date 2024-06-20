
publisher_names <- unique(heroes$Publisher)

for (eachpub in publisher_names) {
  filtered_by_pub <- heroes[heroes$Publisher == eachpub, ] # filtered df for each pub
  print(eachpub)
  print(nrow(filtered_by_pub))
}

lapply(publisher_names, function(eachpub){
  filtered_by_pub <- heroes[heroes$Publisher == eachpub, ] # filtered df for each pub
  print(eachpub)
  print(nrow(filtered_by_pub))
})

sum_of_squares <- function(input_value) {
  sum(input_value^2)
}

sum_of_squares(1:4)
