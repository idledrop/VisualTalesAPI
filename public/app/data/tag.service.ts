import {Injectable} from 'angular2/core';
import {Http, URLSearchParams} from 'angular2/http';
import {Observable} from 'rxjs/Observable';

@Injectable()
export class TagService {
  private _tagsUrl:string = 'api/tags'; 
  
  constructor(private _http:Http) { }

  getTags(tagName=''){
    let params:URLSearchParams = new URLSearchParams();
    
    if(tagName.length == 0){
      params.set('query', tagName);
    }
    
    return this._http.get(this._tagsUrl, {search:params})
               .map(res => <ITag[]> res.json())
               .catch(this.logError);
  }
  
  createTag(tag:ITag){
    return this._http.post(this._tagsUrl, JSON.stringify(tag))
               .map(res => <ITag> res.json())
               .catch(this.logError);
  }
  
  private logError(error: Error){
    console.log(error);
    return Observable.throw(error);
  }
}

export interface ITag{
  id?:number;
  name:string;
}
