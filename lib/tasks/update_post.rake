namespace :db do
  desc "更新文章序號"
  task :update_post_serial => :environment do
    Post.all.where(serial: nil).each do |post|
      post.update(serial: serial_generator(10))
    end
    puts "done!"
  end

  private
  def serial_generator(n)
    [*"a".."z", *"A".."Z", *0..9].sample(n).join
    print "."
  end

end