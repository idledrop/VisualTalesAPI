import {Component, OnInit} from 'angular2/core';
import {Control, FORM_DIRECTIVES} from 'angular2/common';

import {Observable} from 'rxjs/Observable';
import {Subject} from 'rxjs/Subject';

import {StoryService, IStory} from './stories';

@Component({
  selector: 'stories',
  templateUrl: `app/stories/stories.component.html`,
  directives: [FORM_DIRECTIVES]
})

export class StoriesComponent implements OnInit {
  shownStories:Observable<IStory[]>;
  storyComponentObservable:Subject<{}>;
  
  titleControl = new Control();
  
  title:string;
  tags:any[];
  error:string;
  
  constructor(private _storyService:StoryService) {
    this.storyComponentObservable = new Subject();
    
    let titleObservable = this.titleControl.valueChanges
                 .debounceTime(1000)
                 .distinctUntilChanged();
      
    this.shownStories = Observable.merge(this.storyComponentObservable, titleObservable)
            .switchMap(output => this._storyService.getStories({title:this.title, tag_ids:this.tags}));
  }
  
  ngOnInit() {
    this.tags = [];
    this.storyComponentObservable.next(this.tags);
  }
}