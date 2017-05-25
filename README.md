# KokoMusic

KokoMusic was Jeffrey Hechler, Frederico De Paoli, and Ian Boynton’s first Ruby on Rails application.

<h3>About KokoMusic</h3>

KokoMusic is a music discovery application that utilizes Spotify’s API to allow users to search for songs, add reviews and up/down vote other users’ reviews. The application leverages a users’ voting data to provide them with a dashboard of curated suggestions, as well as views for the songs and artists trending across the site.

Personalized recommendations come from three data segments:

<ol>
<li>The last 100 reviews from a user’s friend group.</li>
<li>The last positive review from the user’s that have written reviews that have received the most up-votes.</li>
<li>The last positive review from the user’s that the signed-in user has up-voted the most.</li>
</ol>

The song and artists views’ use average weighted reviews to determine what qualifies as trending. Using web sockets, our application records and reflects up-vote activity in real-time. At the point of recording up-votes, the song’s weighted average review is re-calculated, negating reviews with negative up-vote totals.


<h4>Technologies Used</h4>

<ul>
<li>Ruby on Rails</li>
<li>jQuery</li>
<li>Web Sockets</li>
<li>Bootstrap/CSS</li>
<li>ActiveRecord</li>
<li>PostgreSQL</li>
<li>bcrypt </li>
<li>RESTful API Architecture</li>
<li>Spotify API Integration</li>
</ul>

