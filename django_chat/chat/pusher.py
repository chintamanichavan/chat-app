import pusher

pusher_client = pusher.Pusher(
  app_id='1643521',
  key='5e8ceb2bfcbc047fe040',
  secret='4318ec44a5b1fb2867fe',
  cluster='us2',
  ssl=True
)

#pusher_client.trigger('my-channel', 'my-event', {'message': 'hello world'})