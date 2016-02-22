import {Component, OnInit} from 'angular2/core';
import {StoryService,IStory,ICharacter,IScene} from '../data/data';
import {RouteParams, Router} from 'angular2/router';

import {ImagePanelListComponent} from '../components/image-panel-list.component';

import {Observable} from 'rxjs/Observable';

@Component({
  selector: 'story-editor',
  templateUrl: 'app/stories/story-editor.component.html',
  directives: [ImagePanelListComponent]
})

export class StoryEditorComponent implements OnInit {
	
	story:IStory;
  characters:ICharacter[];
  scenes:IScene[];

  constructor(private _storyService:StoryService, private _routeParams:RouteParams, private _router:Router) { }
  
  ngOnInit() {
    let storyId:number = parseInt(this._routeParams.get('id'), 10);
    
    Observable.forkJoin(
      this._storyService.getStory(storyId),
      this._storyService.getCharactersForStory(storyId),
      this._storyService.getScenesForStory(storyId)
    ).subscribe(
      storyInfo => {
        this.story = storyInfo[0];
        this.characters = storyInfo[1];
        this.scenes = storyInfo[2];
      },
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
  
  selectScene = (scene:IScene) => {
    this._router.navigate(['SceneEditor', {id:scene.id}]);
  }
}