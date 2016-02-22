import {Component, OnInit} from 'angular2/core';
import {StoryService,IStory} from '../data/data';
import {RouteParams} from 'angular2/router';

@Component({
  selector: 'story-editor',
  templateUrl: 'app/stories/story-editor.component.html'
})

export class StoryEditorComponent implements OnInit {
	
	story:IStory;

  constructor(private _storyService:StoryService, private _routeParams:RouteParams) { }
  
  ngOnInit() { 
  	 this._storyService.getStory(parseInt(this._routeParams.get('id'), 10))
        .subscribe(
          story => this.story = story,
          error => alert('unable to retrieve story')
        );
  }

  update() {
  	this._storyService.updateStory(this.story)
        .subscribe(
          story => this.story = story,
          error => alert('unable to retrieve story')
        );
  }
}