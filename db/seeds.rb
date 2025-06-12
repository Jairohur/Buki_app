require "open-uri"
require 'csv'

puts "🌱 Seeding database..."

Page.destroy_all
Book.destroy_all
User.destroy_all

puts "📚 Creating books..."

# book_data = [
#   # {
#   #   title: "Peter's Bizarre Adventures",
#   #   author: "Harry Potter",
#   #   description: "Peter goes on a batshit crazy journey in his sleep.",
#   #   language: "English",
#   #   cover_image: "Peter's Bizarre Adventures.jpg"
#   # },
#   {
#     title: "The Story of a Fierce Bad Rabbit",
#     author: "Beatrix Potter",
#     description: "This, along with The Tale of Miss Moppet, was intended for very young children...",
#     language: "English",
#     cover_image: "The Story of a Fierce Bad Rabbit.jpg"
#   },
#   {
#     title: "The Tale of Peter Rabbit",
#     author: "Beatrix Potter",
#     description: "The classic tale of a mischievous rabbit who gets into trouble...",
#     language: "English",
#     cover_image: "The Tale of Peter Rabbit.jpg"
#   },
#   {
#     title: "Le Petit Prince",
#     author: "Antoine de Saint-Exupéry",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "Le Petit Prince.jpg"
#   },
#   {
#     title: "Don Quixote",
#     author: "Miguel de Cervantes",
#     description: "An aging nobleman sets out to revive chivalry, battling imaginary enemies...",
#     language: "Spanish",
#     cover_image: "Don Quixote.jpg"
#   },
#   {
#     title: "About Bunnies",
#     author: "Gladys Nelson Muter",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "bunnies01.jpg"
#   },
#   {
#     title: "The Adventures of Squirrel Fluffytail",
#     author: "Dolores McKenna",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "01_Adventures_Squirrel_Fluffytail.jpg"
#   },
#     {
#     title: "Adventures of the Teenie Weenies",
#     author: "Wm. Donahey",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "01_Adventures_of_the_Teenie_Weenies.jpg"
#   },
#     {
#     title: "Aesop's Fables Book 1",
#     author: "Aesop",
#     description: "Dating back to the 6th century BC, Aesop's Fables tell universal truths through the use of simple allegories that are easily understood. Though almost nothing is known of Aesop himself, and some scholars question whether he existed at all, these stories stand as timeless classics known in almost every culture in the world....",
#     language: "French",
#     cover_image: "01_Aesops_Fables_Bk1.jpg"
#   },
#     {
#     title: "De Avonturen Van Kleinen Piet",
#     author: "J.J.A. Goevernor",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "01_de_avonturen_va_klienen_piet.jpg"
#   },
#   {
#     title: "My Father's Dragon",
#     author: "Ruth Stiles Gannett",
#     description: "'My Father's Dragon' by Ruth Stiles Gannett is a children's novel written in the late 1940s. The book tells the enchanting tale of a young boy named Elmer Elevator, who embarks on an adventurous journey to rescue a baby dragon from the treacherous Wild Island...",
#     language: "French",
#     cover_image: "my_father's_dragon_cover.jpg"
#   },
#   {
#     title: "The Tower of Treasure",
#     author: "Franklin W. Dixon",
#     description: "'The Tower Treasure' by Franklin W. Dixon is a mystery novel likely written in the early 20th century. The story introduces the Hardy Boys, Frank and Joe, who are eager to follow in their father's footsteps as detectives. ...",
#     language: "French",
#     cover_image: "the_tower_of_treasure_illusc.jpg"
#   },
#   {
#     title: "Mother McGrew and Tommy Turkey",
#     author: "Alice Crew Gall",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "01mtt.jpg"
#   },
#   {
#     title: "On The Trail of The Space Pirates",
#     author: "Carey Rockwell",
#     description: "'On the Trail of the Space Pirates' by Carey Rockwell is a science fiction novel written in the early 1950s. This adventurous story follows the exploits of Tom Corbett and his fellow Space Cadets—Roger Manning and Astro—as they navigate the challenges of space travel while facing the threat of nefarious space pirates. Their journey begins as they return to Space Academy, where they are soon pulled into a mysterious plot involving stolen secrets and a race against time to protect interplanetary peace. The opening of the novel introduces the main characters on their way back to the Space Academy, where they will receive new assignments. ...",
#     language: "English",
#     cover_image: "on_the_trail_of_the_space_pirates_cover.jpg"
#   },
#   {
#     title: "Raggedy Ann Stories",
#     author: "Johnny Gruelle",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "raggedy_ann_stories_title.jpg"
#   },
#   {
#     title: "Around the World in a Berry Wagon",
#     author: "",
#     description: "Un conte poétique et philosophique sous l'apparence d'un conte pour enfants...",
#     language: "French",
#     cover_image: "01atwCover.jpg"
#   },
# ]


# book_data.each do |attrs|
#   image_file = attrs.delete(:cover_image)
#   book = Book.create!(attrs)
#   puts "✅ Created '#{book.title}' by #{book.author}"

#   # Attach cover image to Book
#   file = File.open(Rails.root.join("app/assets/images/#{image_file}"))
#   book.cover_image.attach(io: file, filename: image_file, content_type: "image/jpeg")

#   # Select either 14 real or 5 placeholder pages
#   pages = real_pages[book.title] || Array.new(5) { |i| "This is page #{i + 1} of #{book.title}." }

#   pages.each_with_index do |text, i|
#     page = Page.create!(
#       book: book,
#       text: { "EN" => text },
#       page_number: i + 1
#     )

#     # Choose image for page
#     page_image = if book.title == "Peter's Bizarre Adventures"
#                    "PBA P#{i + 1}.jpg"
#                  else
#                    image_file
#                  end

#     image_path = Rails.root.join("app/assets/images", page_image)
#     if File.exist?(image_path)
#       file = File.open(image_path)
#       page.photo.attach(io: file, filename: page_image, content_type: "image/jpeg")
#       puts "🖼️ Attached '#{page_image}' to Page #{page.page_number} of '#{book.title}'"
#     else
#       puts "⚠️ Image '#{page_image}' not found for Page #{page.page_number} of '#{book.title}'"
#     end
#   end
# end

# Create more books, images from Cloudinary and text from another file (csv)
puts "📚 Creating more books..."

# Kaho's Google Spreadsheet URL for book data
CSV_URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQRd6BbqFOZf8o2Gn6qA9JneuGwEALnh5z-qNjbtLiI6A1-naXCP9QnzjpBZfo5ms-1RjtEs6h-p5b2/pub?output=csv"
csv_data = URI.open(CSV_URL).read
books_csv = CSV.parse(csv_data, headers: true)

books_csv.each do |row|
  title = row["Title"]
  author = row["Author"]
  description = row["Description"]
  language = row["Language"]
  cover_url = row["CoverImageURL"]

  book = Book.create!(
    title: title,
    author: author,
    description: description,
    language: language,
  )
  puts "✅ Created book: #{title}"

# Attach cover from Cloudinary
  file = URI.open(cover_url)
  book.cover_image.attach(io: file, filename: File.basename(cover_url), content_type: "image/jpeg")

  # Add page texts and images
  row.headers.select { |h| h.match?(/\d+$/) }.each do |page_column|
  page_number = page_column[/\d+/].to_i
  text = row[page_column]
  next unless text.present?

    page = Page.create!(
      book: book,
      text: { "EN" => text },
      page_number: page_number
    )

    # Example of attaching an image if your naming matches (e.g. "book_title_P1.jpg")
   image_column = "#{page_number}ImageURL"
    if row[image_column].present?
      page_image_url = row[image_column]
      file = URI.open(page_image_url)
      page.photo.attach(io: file, filename: File.basename(page_image_url), content_type: "image/jpeg")
      puts "🖼️ Attached Cloudinary image to Page #{page_number} of '#{book.title}'"
    else
      puts "⚠️ No image URL for Page #{page_number} of '#{book.title}'"
    end
  end
end


puts "👤 Creating a test user..."

User.create!(
  email: "test@test.com",
  password: "123123",
  password_confirmation: "123123",
  first_name: "Jairo",
  last_name: "Hurtado",
  username: "Jairo",
  languages: ["EN", "JA", "ES"]
)

puts "🌱 Done seeding!"
