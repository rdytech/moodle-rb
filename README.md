# Moodle
Moodle Ruby Client

## Usage

Build a Moodle client
```
moodle = Moodle.new(webservices_token, moodle_url)
```

Get site information
```
moodle.site_info

=> {"version"=>"2014111003.02", "firstname"=>"James", "release"=>"2.8.3+ (Build: 20150212)", ... }
```

Create a course
```
moodle.courses.create(
  :full_name => 'My Course',
  :short_name => 'MyC',
  :parent_category => 5,
  :idnumber => 'ExtRef'
)

=> {"id"=>32, "shortname"=>"MyC"}
```

List all courses
```
moodle.courses.index

=> {"lang"=>"", "maxbytes"=>0, "summary"=>"", "forcetheme"=>"", "visible"=>1, "format"=>"site", "numsections"=>0, "idnumber"=>"", "completionnotify"=>0, "showreports"=>0, "categoryid"=>5, "groupmodeforce"=>0, "newsitems"=>0, "defaultgroupingid"=>0, "showgrades"=>1, "categorysortorder"=>1, "startdate"=>0, "courseformatoptions"=>[{"value"=>0, "name"=>"numsections"}], "groupmode"=>0, "summaryformat"=>1, "fullname"=>"My Course", "id"=>32, "enablecompletion"=>0, "timemodified"=>1418875734, "timecreated"=>1399990921, "shortname"=>"MyC"}
```
