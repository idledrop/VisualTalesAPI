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

  getStories({title='', tag_ids=[], page=1, page_size=20}){
    let params:URLSearchParams = new URLSearchParams();
    params.set('title', title);
    params.set('tag_ids', tag_ids.join(','));
    params.set('page', page.toString());
    params.set('page_size', page_size.toString());
      
    return this._http.get(this._storiesUrl)
               .map(res => <IStory[]> res.json())
               .catch(this.logError);    
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