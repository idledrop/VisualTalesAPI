import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService, ICharacter, IScene, ITag} from './data';

@Injectable()
export class StoryService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<IStory>){ 
    this._visualTalesHttp.setUrl('stories');
  }

  getStory(id:number):Observable<IStory>{
    return this._visualTalesHttp.get(id);
  }

  getStories(searchParams:any):Observable<IStory[]>{
    let params:any = this.getStoryParams(searchParams);
    return this._visualTalesHttp.getAll(params); 
  }
  
  private getStoryParams({title='', tag_ids=[], page=1, page_size=20}):any{
    let params:any = {};
    
    if(title.length > 0){
      params.title = title;
    }
        
    if(tag_ids.length > 0){
      params.tagIds = tag_ids.join(',');    
    }
    
    params.page = page.toString();
    params.page_size = page_size.toString();
    
    return params;
  }
  
  createStory(story:IStory):Observable<IStory>{
    return this._visualTalesHttp.create(story);
  }
  
  updateStory(story:IStory):Observable<IStory>{
    return this._visualTalesHttp.update(story);
  }
  
  
  addCharacterToStory(id:number, payload:any):Observable<ICharacter>{
    return this._visualTalesHttp.createChild<ICharacter>(id, 'characters', payload);
  }
  
  getCharactersForStory(id:number):Observable<ICharacter[]>{
    return this._visualTalesHttp.getChildren<ICharacter>(id, 'characters');
  }
  
  
  addSceneToStory(id:number, payload:any):Observable<IScene>{
    return this._visualTalesHttp.createChild<IScene>(id, 'scenes', payload);  
  }
  
  getScenesForStory(id:number):Observable<IScene[]>{
    return this._visualTalesHttp.getChildren<IScene>(id, 'scenes');
  }
  
  
  addTagToStory(id:number, payload:any):Observable<ITag>{
    return this._visualTalesHttp.createChild<ITag>(id, 'tags', payload);
  }
  
  getTagsForStory(id:number):Observable<ITag[]>{
    return this._visualTalesHttp.getChildren<ITag>(id, 'tags');
  }
}

export interface IStory{
  id:number;
  title:string;
  description?:string;
  characters?:any[];
  scenes?:any[];
};