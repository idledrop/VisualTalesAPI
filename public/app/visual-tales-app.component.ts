import {Component, OnInit} from 'angular2/core';
import {RouteConfig, ROUTER_PROVIDERS, ROUTER_DIRECTIVES} from 'angular2/router';
import {HTTP_PROVIDERS} from 'angular2/http';

import {HomeComponent} from './home/home';
import {ViewStoryComponent, StoryService} from './stories/stories';

@Component({
  selector: 'visual-tales-app',
  template:`<router-outlet></router-outlet>`,
  directives: [ROUTER_DIRECTIVES],
  providers: [
      ROUTER_PROVIDERS, 
      HTTP_PROVIDERS,
      StoryService
  ]
})

@RouteConfig([
  {path:'/...', name:'Home', component:HomeComponent, useAsDefault:true},
  {path:'/view-story/:id', name:'ViewStory', component:ViewStoryComponent}
])

export class VisualTalesAppComponent implements OnInit {

  constructor() { }

  ngOnInit() { }
}