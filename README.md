# Database Optimizations

#### Documentation
- [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
- [Active Job](http://edgeguides.rubyonrails.org/active_job_basics.html)
- [Delayed Job](https://github.com/collectiveidea/delayed_job)
- [Daemons](https://github.com/thuehlinger/daemons)

#### In the console
```
bin/delayed_job --queues=default,mailers start
bin/delayed_job --queues=default,mailers stop
```

#### [Cron][1]
```
* 0 * * * /Users/byrd/tiy/projects/database_optimizations/bin/delayed_job --queue=nightly start
* 4 * * * /Users/byrdtiy/projects/database_optimizations/bin/delayed_job --queue=nightly stop
```

#### [Gemfile][2]
```rb
gem 'delayed_job'
gem 'daemons'
gem 'delayed_job_active_record'
```

#### [Migration][3]
```rb
class AddIndices < ActiveRecord::Migration
  def change
    add_index :assemblies, :name
    add_index :sequences, :assembly_id
    add_index :genes, :sequence_id
    add_index :hits, :subject_id
  end
end
```

#### [Assembly model][4]
```rb
class Assembly < ActiveRecord::Base
  has_many :sequences
  has_many :genes, through: :sequences
  has_many :hits, through: :genes
end
```

#### [Report Mailer][5]
```rb
class ReportMailer < ApplicationMailer
  def report(address, name = "a1")
    @address = address
    @assembly = Assembly.find_by_name(name)
    @hits = @assembly.hits.order("percent_similarity DESC")
    mail(to: @address, subject: "Heres that DNA you ordered")
  end
end
```
[1]: http://www.unixgeeks.org/security/newbie/unix/cron-1.html
[2]: https://github.com/michaelbyrd/database-optimization/blob/master/Gemfile
[3]: https://github.com/michaelbyrd/database-optimization/blob/master/db/migrate/20150309181117_add_indices.rb
[4]: https://github.com/michaelbyrd/database-optimization/blob/master/app/models/assembly.rb
[5]: https://github.com/michaelbyrd/database-optimization/blob/master/app/mailers/report_mailer.rb
