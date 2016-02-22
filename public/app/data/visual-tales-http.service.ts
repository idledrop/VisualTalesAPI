import {Injectable} from 'angular2/core';
import {Http, URLSearchParams, Headers} from 'angular2/http';
import {Observable} from 'rxjs/Observable';

@Injectable()
export class VisualTalesHttpService<T> {
  private _putPostHeaders:Headers;
  private _url:string;
  
  constructor(private _http:Http) {
    this._putPostHeaders = new Headers();
    this._putPostHeaders.append('Content-Type', 'application/json');
  }
  
  setUrl(url:string){
    this._url = `api/${url}`;
  }
  
  get(id:number):Observable<T>{
    return this.getForUrl<T>(`${this._url}/${id}`);
  }
  
  getChild<C>(id:number, childPath:string, childId:number):Observable<C>{
    return this.getForUrl<C>(`${this._url}/${id}/${childPath}/${childId}`);
  }
  
  private getForUrl<A>(url:string):Observable<A>{
    return this._http.get(url)
                .map(res => <A> res.json())
                .catch(this.logError);
  }
  
  getAll(params?:any):Observable<T[]>{
    return this.getAllForUrl<T>(this._url, params);
  }
  
  getChildren<C>(id:number, childPath:string, params?:any):Observable<C[]>{
    return this.getAllForUrl<C>(`${this._url}/${id}/${childPath}`, params);
  }
  
  private getAllForUrl<A>(url:string, params?:any):Observable<A[]>{
    let urlParams:URLSearchParams = this.getUrlParams(params);    
    
    return this._http.get(url, {search:urlParams})
               .map(res => <A[]> res.json())
               .catch(this.logError);
  }
  
  private getUrlParams(params:any):URLSearchParams{
    let urlParams:URLSearchParams = new URLSearchParams();
    
    if(!params){
      return urlParams;
    }
    
    return Object.keys(params)
                .reduce(function(searchParams, keyName){
                  searchParams.set(keyName, params[keyName]);
                  return searchParams;
                }, urlParams);
  }
  
  update(payload:any):Observable<T>{
    return this.updateForUrl<T>(`${this._url}/${payload.id}`, payload);
  }
  
  updateChild<C>(id:number, childPath:string, payload:any):Observable<C>{
    return this.updateForUrl<C>(`${this._url}/${id}/${childPath}/${payload.id}`, payload);
  }
  
  private updateForUrl<A>(url:string, payload:any):Observable<A>{
    return this._http.put(
              url,
              JSON.stringify(payload), 
              {headers: this._putPostHeaders}
            )
            .map(res => <A> res.json())
            .catch(this.logError);
  }
  
  create(payload:any):Observable<T>{
    return this.createForUrl<T>(this._url, payload);
  }
  
  createChild<C>(id:number, childPath:string, payload:any):Observable<C>{
    return this.createForUrl<C>(`${this._url}/${id}/${childPath}`, payload);
  }
  
  private createForUrl<A>(url:string, payload:any):Observable<A>{
    return this._http.post(
              url,
              JSON.stringify(payload),
              {headers: this._putPostHeaders}
           )
           .map(res => <A> res.json())
           .catch(this.logError);
  }
  
  delete(id:number):Observable<{}>{
    return this.deleteForUrl(`${this._url}/${id}`);
  }
  
  private deleteForUrl(url:string):any{
    return this._http.delete(url)
           .map(res => res.json())
           .catch(this.logError);
  }
  
  private logError(error: Error){
    console.log(error);
    return Observable.throw(error);
  }
}