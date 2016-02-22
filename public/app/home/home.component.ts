import {Component} from 'angular2/core';
import {RouteConfig, ROUTER_DIRECTIVES} from 'angular2/router';

import {StoriesComponent, StoryEditorComponent} from '../stories/stories';
import {SceneEditorComponent} from '../scenes/scenes';

@Component({
  selector: 'home',
  templateUrl: 'app/home/home.component.html',
  styleUrls: ['app/home/home.component.css'],
  directives: [ROUTER_DIRECTIVES]
})

@RouteConfig([
  {path:'/stories', name:'Stories', component:StoriesComponent, useAsDefault:true},
  {path:'/stories/:id', name:'StoryEditor', component:StoryEditorComponent},
  {path:'/scene/:id', name:'SceneEditor', component:SceneEditorComponent}
])

export class HomeComponent {
  
}