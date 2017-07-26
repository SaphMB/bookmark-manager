DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/bookmark_manager_development')
DataMapper.finalize
DataMapper.auto_upgrade!
