import {Component, OnInit} from 'angular2/core';
import {RouteConfig, ROUTER_DIRECTIVES} from 'angular2/router';

import {HomeComponent} from './home/home';
import {ViewStoryComponent} from './stories/stories';

@Component({
  selector: 'visual-tales-app',
  template:`<router-outlet></router-outlet>`,
  directives: [ROUTER_DIRECTIVES]
})

@RouteConfig([
  {path:'/...', name:'Home', component:HomeComponent, useAsDefault:true},
  {path:'/view-story/:id', name:'ViewStory', component:ViewStoryComponent}
])

export class VisualTalesAppComponent implements OnInit {

  constructor() { }

  ngOnInit() { }
}