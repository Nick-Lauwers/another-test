EXTERNAL_DB = YAML.load_file(File.join(Rails.root, "config", "external_db.yml"))[Rails.env.to_s]  

