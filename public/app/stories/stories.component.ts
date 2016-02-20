import {Component, OnInit} from 'angular2/core';

import {StoryService} from './stories';

@Component({
  selector: 'stories',
  templateUrl: 'app/stories/stories.component.html'
})

export class StoriesComponent implements OnInit {

  constructor() { }

  ngOnInit() { }
}