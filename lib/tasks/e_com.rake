require 'faker'

namespace :e_com do

  namespace :db do

    desc 'DB Clear'
    task clear: :environment do
      User.destroy_all
      Product.destroy_all
      Cart.destroy_all
      Order.destroy_all
      LineItem.destroy_all
    end

    desc 'DB Rebuild'
    task rebuild: :environment do

    end

  end

end
