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

### Courses

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

=> [{"lang"=>"", "maxbytes"=>0, "summary"=>"", "forcetheme"=>"", "visible"=>1, "format"=>"site", "numsections"=>0, "idnumber"=>"", "completionnotify"=>0, "showreports"=>0, "categoryid"=>5, "groupmodeforce"=>0, "newsitems"=>0, "defaultgroupingid"=>0, "showgrades"=>1, "categorysortorder"=>1, "startdate"=>0, "courseformatoptions"=>[{"value"=>0, "name"=>"numsections"}], "groupmode"=>0, "summaryformat"=>1, "fullname"=>"My Course", "id"=>32, "enablecompletion"=>0, "timemodified"=>1418875734, "timecreated"=>1399990921, "shortname"=>"MyC"}]
```

Show a course
```
moodle.courses.show(32)

=> {"courseformatoptions"=>[{"name"=>"numsections", "value"=>10}, {"name"=>"hiddensections", "value"=>1}, {"name"=>"coursedisplay", "value"=>0}], "enablecompletion"=>1, "timemodified"=>1427925517, "visible"=>1, "summary"=>"", "fullname"=>"Test Course", "forcetheme"=>"", "defaultgroupingid"=>0, "idnumber"=>"ExtRef", "id"=>32, "groupmode"=>0, "startdate"=>0, "groupmodeforce"=>1, "maxbytes"=>0, "categorysortorder"=>50001, "categoryid"=>5, "lang"=>"", "numsections"=>10, "showgrades"=>1, "summaryformat"=>1, "shortname"=>"TestC", "completionnotify"=>0, "showreports"=>0, "newsitems"=>0, "timecreated"=>1427925517, "format"=>"topics", "hiddensections"=>1}
```

Delete a course
```
moodle.courses.destroy(32)

=> true
```

### Categories

Create a category
```
moodle.categories.create(
  :name => 'Test category'
)

=> {"id"=>6, "name"=>"Test category"}
```

List all categories
```
moodle.categories.index

=> [{"timemodified"=>1428368264, "sortorder"=>60000, "parent"=>0, "idnumber"=>"", "name"=>"Test category", "path"=>"/6", "coursecount"=>0, "id"=>6, "visible"=>1, "theme"=>nil, "depth"=>1, "visibleold"=>1, "descriptionformat"=>1, "description"=>""}]
```

Show a category
```
moodle.categories.show(6)

=> {"depth"=>1, "visible"=>1, "theme"=>nil, "descriptionformat"=>1, "description"=>"", "idnumber"=>"", "name"=>"Test category", "sortorder"=>60000, "parent"=>0, "coursecount"=>0, "id"=>6, "timemodified"=>1428368264, "visibleold"=>1, "path"=>"/6"}
```

Delete a category
```
moodle.categories.destroy(6)

=> true
```
