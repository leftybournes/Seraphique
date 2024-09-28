[
    "Best Seller",
    "New Product",
    "Serum",
    "Moisturizer",
    "Body Wash",
    "Night Cream",
    "Facial Cleanser"
].each do |category_name|
    Category.find_or_create_by!(name: category_name)
end
