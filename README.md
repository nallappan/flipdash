Dashing is a ruby framework that lets you build beautiful dashboards. Check out a demo over here. 
Dashing works with widgets. 

**Anatomy of a widget**
an HTML file used for layout and bindings
a SCSS file for styles
a coffeescript file which allows you to handle incoming data & functionality

**Widgets Types** HotState, Meter, Number, Text, HotMeter and HotNumber

**Example Dashboard**

Below is the example dashboard for text & hotstate widgets. Place this file under dashboard directory and name it as dashboard.erb, and it can be accessed at `http://SERVER_IP:3030/dashboard`

```
<% content_for :title do %>Example Dashboard<% end %>
<div class="gridster">
  <ul>
     <li data-row="1" data-col="2" data-sizex="3" data-sizey="1">
      <div data-id="welcome" data-view="Text" data-title="Hello" data-text="This is your shiny new dashboard." data-moreinfo="Protip: You can drag the widgets around!"></div>
    </li>
    <li data-row="2" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="hot" data-view="HotState" data-title="Hotstate"></div>
    </li>
  </ul>
</div>
```

Each widget is represented by a div element needing `data-id` and `data-view` attributes. The wrapping `<li>` tags are used for layout.

**data-id:** 
Sets the widget ID which will be used when pushing data to the widget. Two widgets can have the same widget id, allowing you to have the same widget in multiple dashboards. Push data to that id, and each instance will be updated.

**data-view:**
Specifies the type of widget that will be used.

**Pushing data into your widget**
Sending data to your widget is quite easy. By using your widget id and JSON data, you can pass the data to your widget. There are 2 ways to do this.

**Jobs:**  Dashing uses rufus-scheduler to schedule jobs. You can write a ruby script to send data to the widgets. 

**Syntax:**
`send_event(widget_id, json_formatted_data)`

**Dashboard.rb:** Your widget instance will be updated every 2s with a random number. Please this file under jobs directory.

```
SCHEDULER.every '2s' do
status= ['ok', 'warning', 'critical']
value = rand(100)

 if value > 80
	send_event('hot', { state: status[2], message: value })
 elsif value > 70
	send_event('hot', { state: status[1], message: value })
 else
	send_event('hot', { state: status[0], message: value })
 end
end
```

**API**

You can also send data directly to your widget using HTTP. Post data to /widgets/widget_id
For security, you will also have to include your auth_token (which can be found in config.ru).

`curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Welcome to Flipkart" }' \http://localhost:3030/widgets/welcome`

Another way is to feed your widget using a json file. 

`/usr/bin/curl -d @sample.json http://localhost:3030/widgets/welcome`

**Sample.json:**

```
{
“auth_token”: “tk”
“text”: “Welcome to Flipdash”
}
```


You can write any script(Bash,python or perl) and make use of this API to feed data to your widget.

Check out http://shopify.github.com/dashing for more information.
