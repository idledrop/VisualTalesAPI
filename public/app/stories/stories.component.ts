import {Component, OnInit} from 'angular2/core';
import {Control, FORM_DIRECTIVES} from 'angular2/common';
import {Router} from 'angular2/router';

import {Observable} from 'rxjs/Observable';
import {Subject} from 'rxjs/Subject';

import {StoryService, IStory} from './stories';
import {ImagePanelListComponent} from '../components/image-panel-list.component';

@Component({
  selector: 'stories',
  templateUrl: `app/stories/stories.component.html`,
  directives: [FORM_DIRECTIVES, ImagePanelListComponent]
})

export class StoriesComponent implements OnInit {
  stories:IStory[];
  storyComponentObservable:Subject<{}>;
  
  titleControl = new Control();
  
  title:string;
  tags:any[];
  error:string;
  
  constructor(private _storyService:StoryService, private _router:Router) {
    this.storyComponentObservable = new Subject();
    
    let titleObservable = this.titleControl.valueChanges
                 .debounceTime(800)
                 .distinctUntilChanged();
      
    Observable.merge(this.storyComponentObservable, titleObservable)
        .flatMap(output => this._storyService.getStories({title:this.title, tag_ids:this.tags}))
        .subscribe(
          stories => this.stories = <IStory[]>stories,
          error => this.error = error.toString()
        );
  }
  
  ngOnInit() {
    this.tags = [];
    this.storyComponentObservable.next(this.tags);
  }
  
  selectStory = (story:IStory) => {
      this._router.navigate(['StoryEditor', { id: story.id }]);
  };
}