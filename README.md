# Database Optimizations

#### Documentation
- [Active Record Migrations][ARM]
- [Active Job][AJ]
- [Delayed Job][DJ]
- [Daemons][DAE]
- [Mailers example][MAIL]
- [OSX Cron][CRON]

#### [In the console][DJ]
```
bin/delayed_job --queues=default,mailers start
bin/delayed_job --queues=default,mailers stop
```

#### [Cron][CRON]
```
* 0 * * * /Users/byrd/tiy/projects/database_optimizations/bin/delayed_job --queue=nightly start
* 4 * * * /Users/byrdtiy/projects/database_optimizations/bin/delayed_job --queue=nightly stop
```

#### [Gemfile][GEM]
```rb
gem 'delayed_job'
gem 'daemons'
gem 'delayed_job_active_record'
```

#### [Migration][MIGR]
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

#### [Assembly model][AS]
```rb
class Assembly < ActiveRecord::Base
  has_many :sequences
  has_many :genes, through: :sequences
  has_many :hits, through: :genes
end
```

#### [Report Mailer][RM]
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
[AJ]: http://edgeguides.rubyonrails.org/active_job_basics.html
[ARM]: http://edgeguides.rubyonrails.org/active_record_migrations.html
[AS]: https://github.com/michaelbyrd/database-optimization/blob/master/app/models/assembly.rb
[CRON]: http://www.maclife.com/article/columns/terminal_101_creating_cron_jobs
[DAE]: https://github.com/thuehlinger/daemons
[DJ]: https://github.com/collectiveidea/delayed_job
[GEM]: https://github.com/michaelbyrd/database-optimization/blob/master/Gemfile
[MAIL]: https://github.com/michaelbyrd/mailer_example
[MIGR]: https://github.com/michaelbyrd/database-optimization/blob/master/db/migrate/20150309181117_add_indices.rb
[RM]: https://github.com/michaelbyrd/database-optimization/blob/master/app/mailers/report_mailer.rb
