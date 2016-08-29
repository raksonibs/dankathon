# mix run priv/repo/seeds.exs
# iex(3)> post = EctoBlog.Repo.get_by(EctoBlog.Post, title: "Hello")     
# iex(4)> changed_post = %{post | title: "Hello!"}
# iex(5)> {:ok, updated_post} = EctoBlog.Repo.update(changed_post)
# iex(6)> {:ok, deleted_post} = EctoBlog.Repo.delete(updated_post)   
require IEx
alias Backend.Repo
alias Backend.Meme
alias Backend.Tag
alias Backend.HashTag

repo_memes = Repo.all(Meme)
hash_tags = Repo.all(HashTag)
tags = Repo.all(Tag)

for meme <- repo_memes do 
  Repo.delete!(meme)
end

for ht <- hash_tags do 
  Repo.delete!(ht)
end

for ht <- tags do 
  Repo.delete!(ht)
end

memes = ~w(http://media3.giphy.com/media/fKO3LF3DYpxpm/giphy.gif http://img.memecdn.com/Forever-Alone_o_98121.gif https://media4.giphy.com/media/4pMX5rJ4PYAEM/200_s.gif http://memesvault.com/wp-content/uploads/Okay-Meme-Gif-15.gif http://i.imgur.com/KsYpXaP.gif https://i.imgflip.com/136tm8.jpg http://s.quickmeme.com/img/c9/c9c9573e46b3fb7bd6003c62958f4e9bbe9b305801c1e14dff0ab955172c0f74.jpg http://vignette2.wikia.nocookie.net/meme/images/e/ef/Tumblr_l7kr81x3fz1qzpwi0o1_400.gif/revision/latest?cb=20110830004431 http://memesvault.com/wp-content/uploads/Funny-Meme-13.jpg http://i0.kym-cdn.com/photos/images/newsfeed/000/328/752/fdc.gif http://memesvault.com/wp-content/uploads/Chuck-Norris-Meme-06.jpg http://i2.kym-cdn.com/photos/images/original/000/592/985/7f9.gif https://s-media-cache-ak0.pinimg.com/564x/13/e0/ce/13e0cef23c4323e8d32be0e6322be99a.jpg https://media.giphy.com/media/WHIEuP1pGYZ6U/giphy.gif https://thechive.files.wordpress.com/2016/07/dank-memes-for-the-weekend-28-memes-281.jpg?quality=85&strip=info&w=600&h=450&crop=1 http://memesvault.com/wp-content/uploads/Funny-Workout-Meme-1.jpg https://cdn3.vox-cdn.com/thumbor/ws3MnHJxta_bjt8wP3PiZXZBsZM=/cdn0.vox-cdn.com/uploads/chorus_asset/file/3904558/boromirmeme.jpg https://imgflip.com/s/meme/Creepy-Condescending-Wonka.jpg)
random_hash_tags = ~w(yolo swag pepe elixir ruby erlang vm datass dat ass yo man wass up dog whether tis nobler in the mind to suffer the slings and arrows of outrageous fortune)
random_tags = ~w(funny serious dogs cats aww omg creepy awesome lol badman goodman terrible hell heaven)

for hash_tag <- random_hash_tags do
  hashed_tag = "#{hash_tag}"
  Repo.get_by(HashTag, title: hashed_tag) || Repo.insert!(%HashTag{title: hashed_tag})
end

for tag <- random_tags do
  Repo.get_by(Tag, title: tag) || Repo.insert!(%Tag{title: tag})
end

for meme <- memes do 
  number = round(:rand.uniform * 100000)
  random_string = Integer.to_string(number, 36)
  Repo.get_by(HashTag, title: random_string) || Repo.insert!(%HashTag{title: random_string})
  hash_tags = ["#{random_string}"]
  tags = []

  created_meme = Repo.get_by(Meme, image: meme) || Repo.insert!(%Meme{image: meme, rating: 0, title: random_string})
  Repo.preload created_meme, [:tags, :hash_tags]

  # hash_tags = Repo.all(HashTag)
  # tags = Repo.all(Tag)
  # should these references be has_many_and_belongs_to, which ecto does not have
  # right now breaking for 1, 2, 3/ not sure why? on_replace with changeset
  for x <- [1] do 
    number_hash = round(:rand.uniform * length random_hash_tags)
    number_tag = round(:rand.uniform * length random_tags)
    ht = Enum.at(random_hash_tags, number_hash)
    rt = Enum.at(random_tags, number_tag)

    if ht != nil and rt != nil do
      tag = Repo.get_by!(Tag, title: rt)
      hash_tag = Repo.get_by!(HashTag, title: ht)

      # tag_cs = Enum.map(Tag, &Ecto.Changeset.change/1)
      # hasht_cs = Enum.map(HashTag, &Ecto.Changeset.change/1)

      created_meme
        |> Repo.preload(:hash_tags)
        |> Meme.changeset(%{})
        |> Ecto.Changeset.put_assoc(:hash_tags, [hash_tag])
        |> Repo.update!

      created_meme
        |> Repo.preload(:tags)
        |> Meme.changeset(%{})
        |> Ecto.Changeset.put_assoc(:tags, [tag])
        |> Repo.update!
    end
  end

  
end
