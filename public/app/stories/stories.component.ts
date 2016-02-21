import {Component, OnInit} from 'angular2/core';

import {StoryService, IStory} from './stories';

@Component({
  selector: 'stories',
  templateUrl: 'app/stories/stories.component.html'
})

export class StoriesComponent implements OnInit {
  constructor(private _storyService:StoryService) { }
  
  shownStories:IStory[];
  
  ngOnInit() {
    this._storyService.getStories({})
        .subscribe(
          stories => this.shownStories = stories,
          error => alert('unable to retrieve stories')
        );
  }
}