# MoodleRb
A Ruby Client for the Moodle REST API.

https://docs.moodle.org/dev/Web_services#Developer_documentation

## Usage

Initialise a MoodleRb client
```
moodle = MoodleRb.new(webservices_token, moodle_url)
```

Get site information
```
moodle.site_info
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
```

List all courses
```
moodle.courses.index
```

Show a course
```
moodle.courses.show(course_id)
```

Delete a course
```
moodle.courses.destroy(course_id)
```

### Categories

Create a category
```
moodle.categories.create(
  :name => 'Test category'
)
```

List all categories
```
moodle.categories.index
```

Show a category
```
moodle.categories.show(category_id)
```

Delete a category
```
moodle.categories.destroy(category_id)
```

### Enrolments

Create an enrolment
```
moodle.enrolments.create(
  :user_id => user_id,
  :course_id => course_id
)
```

View enrolled users by course
```
moodle.courses.enrolled_users(course_id)
```

View enrolled courses by user
```
moodle.users.enrolled_courses(user_id)
```

### Users

Create a user
```
moodle.users.create(
  :username => 'brucew',
  :password => 'password',
  :firstname => 'Bruce',
  :lastname => 'Wayne',
  :email => 'bruce@wayneenterprises.com'
)
```

Show a user
```
moodle.users.show(user_id)
```

Delete a user
```
moodle.users.destroy(user_id)
```

Search for a user
```
moodle.users.search(:email => 'admin@localhost')
```

Update a user
```
moodle.users.update(:id => 4, :email => 'bwayne@wayneenterprises.com')
```

## Tests

You will need to set some environment variables to create new cassettes. We build using MAMP https://www.mamp.info/en/ so it might be

```
export MOODLE_URL=http://localhost:8888/moodle29/
export MOODLE_TOKEN=87b95af2df709fa60b395b5c59a3fc2e
```
