# trello2markdown

## Set up and run

[Get API key and generate token](https://trello.com/app-key).

Set them to `.env`.

```.env
TRELLO_DEVELOPER_PUBLIC_KEY=API_KEY
TRELLO_MEMBER_TOKEN=API_TOKEN
```

```
bundle install
```

```
ruby trello2markdown.rb
```

If you want to copy output to clipboard(MacOS).

```
ruby trello2markdown.rb | pbcopy
```
