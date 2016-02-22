import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService} from '../data/data';

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
  
  createStory(story:IStory){
      return this._visualTalesHttp.create(story);
  }
  
  updateStory(story:IStory){
      return this._visualTalesHttp.update(story);
  }
}

export interface IStory{
  id:number;
  title:string;
  description?:string;
  characters?:any[];
  scenes?:any[];
};