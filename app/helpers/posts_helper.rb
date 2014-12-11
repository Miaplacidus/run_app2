module PostsHelper

  def get_gender(current_user_gender)
   gender = ""
   if current_user_gender == 0
    gender = "none"
   elsif current_user_gender == 1
    gender = "Women"
   else
    gender = "Men"
   end
  end

end
