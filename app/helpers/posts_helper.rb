module PostsHelper

  def get_gender(current_user_gender)
   gender = ""
   if current_user_gender == "unspecified"
    gender = "none"
   elsif current_user_gender == "female"
    gender = "Women"
   else
    gender = "Men"
   end
  end

end
