# console.log

A blogging platform for software developers and engineers.
Or Medium.com, without the UX. Or functionality. Or userbase. Or anything.

[Live demo on Heroku](http://console-log.herokuapp.com/)

[User stories on Trello](https://trello.com/b/YrmDaA5q/wdi-console-log)

## Technologies used
- Ruby
- Sinatra
- ActiveRecord
- HTML + ERB
- CSS
- [Redcarpet - Markdown processor](https://github.com/vmg/redcarpet)

## Approach taken
- Wrote out user stories
- Database design
- Wireframes
- Core functionality
- Security stuff
- Extra functionality

## Installation instructions
```
Create postgresql database
Execute statements from console-log.sql in database
ruby app.rb
```

## Unsolved problems
- Inaccurate reading time estimate
- No update / delete operations for comments
- No restriction on image dimensions

## Future stuff
- AJAXification
- Improve UX
- Advanced search system
  - By author
  - By date range
  - Sort by votes / views
- Comment CRUD operations
- Likes on individual comments
- Post tagging system
- Admin interface / dashboard
- Moderation / curation system
- User management and permissions
- Additional post formatting options
- Restrict formatting options in comments
- Break post into snippets / paragraphs
  - Comments per snippet
- Save post as draft
- Post visibility options
