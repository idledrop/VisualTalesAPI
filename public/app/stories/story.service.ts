import {Injectable} from 'angular2/core';
import {Http, URLSearchParams} from 'angular2/http';

import {Observable} from 'rxjs/Observable';

@Injectable()
export class StoryService {
  private _storiesUrl:string = 'api/stories';
  
  constructor(private _http:Http) { }

  getStory(id:number){
    return this._http.get(this._storiesUrl + '/' + id)
                .map(res => <IStory> res.json())
                .catch(this.logError);
  }

  getStories(searchParams:Object){
    let params:URLSearchParams = this.getStoryParams(searchParams);
      
    return this._http.get(this._storiesUrl, {search:params})
               .map(res => <IStory[]> res.json())
               .catch(this.logError);    
  }
  
  private getStoryParams({title='', tag_ids=[], page=1, page_size=20}):URLSearchParams{
    let searchParams:URLSearchParams = new URLSearchParams();
    if(title.length > 0){
      searchParams.set('title', title);
    }
        
    if(tag_ids.length > 0){
      searchParams.set('tag_ids', tag_ids.join(','));    
    }
    
    searchParams.set('page', page.toString());
    searchParams.set('page_size', page_size.toString());
    
    return searchParams;
  }
  
  createStory(story:IStory){
      return this._http.post(this._storiesUrl, JSON.stringify(story))
                 .map(res => <IStory> res.json())
                 .catch(this.logError);
  }
  
  updateStory(story:IStory){
      return this._http.put(this._storiesUrl + '/' + story.id, JSON.stringify(story))
                 .map(res => <IStory> res.json())
                 .catch(this.logError);
  }
   
  private logError(error: Error){
    console.log(error);
    return Observable.throw(error);
  }
}

export interface IStory{
  id:number;
  title:string;
  description?:string;
  characters?:any[];
  scenes?:any[];
};