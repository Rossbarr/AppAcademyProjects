namespace :prune do
    desc "Prune unused urls"
    task prune: :environment do
        n = ENV['n'].to_i || 10
        puts "pruning unused urls"
        ShortenedUrl.prune(n)
    end
end