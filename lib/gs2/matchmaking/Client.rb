require 'gs2/core/AbstractClient.rb'

module Gs2 module Matchmaking
  
  # GS2-Matchmaking クライアント
  #
  # @author Game Server Services, Inc.
  class Client < Gs2::Core::AbstractClient
  
    @@ENDPOINT = 'matchmaking'
  
    # コンストラクタ
    # 
    # @param region [String] リージョン名
    # @param gs2_client_id [String] GSIクライアントID
    # @param gs2_client_secret [String] GSIクライアントシークレット
    def initialize(region, gs2_client_id, gs2_client_secret)
      super(region, gs2_client_id, gs2_client_secret)
    end
    
    # デバッグ用。通常利用する必要はありません。
    def self.ENDPOINT(v = nil)
      if v
        @@ENDPOINT = v
      else
        return @@ENDPOINT
      end
    end

    # マッチメイキングリストを取得
    # 
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * matchmakingId => マッチメイキングID
    #       * ownerId => オーナーID
    #       * name => マッチメイキング名
    #       * description => 説明文
    #       * type => 種類
    #       * maxPlayer => 最大プレイヤー数
    #       * serviceClass => サービスクラス
    #       * callback => コールバックURL
    #       * createAt => 作成日時
    #       * updateAt => 更新日時
    #   * nextPageToken => 次ページトークン
    def describe_matchmaking(pageToken = nil, limit = nil)
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Matchmaking', 
            'DescribeMatchmaking', 
            @@ENDPOINT, 
            '/matchmaking',
            query);
    end
  
    # サービスクラスリストを取得
    #
    # @return [Array] サービスクラス
    def describe_service_class()
      query = {}
      result = get(
          'Gs2Matchmaking',
          'DescribeServiceClass',
          @@ENDPOINT,
          '/matchmaking/serviceClass',
          query);
      return result['items'];
    end
    
    # マッチメイキングを作成<br>
    # <br>
    # GS2-Matchmaking を利用するためにまず作成するデータモデルです。<br>
    # マッチメイキングの設定項目として、マッチメイキングの方式や最大プレイヤー数を設定します。<br>
    # 
    # @param request [Array]
    #   * name => マッチメイキング名
    #   * description => 説明文
    #   * serviceClass => サービスクラス
    #   * type => 種類
    #   * maxPlayer => 最大プレイヤー数
    #   * callback => コールバックURL
    # @return [Array]
    #   * item
    #     * matchmakingId => マッチメイキングID
    #     * ownerId => オーナーID
    #     * name => マッチメイキング名
    #     * description => 説明文
    #     * type => 種類
    #     * maxPlayer => 最大プレイヤー数
    #     * serviceClass => サービスクラス
    #     * callback => コールバックURL
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def create_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('serviceClass'); body['serviceClass'] = request['serviceClass']; end
      if request.has_key?('type'); body['type'] = request['type']; end
      if request.has_key?('maxPlayer'); body['maxPlayer'] = request['maxPlayer']; end
      if request.has_key?('callback'); body['callback'] = request['callback']; end
      query = {}
      return post(
            'Gs2Matchmaking', 
            'CreateMatchmaking', 
            @@ENDPOINT, 
            '/matchmaking',
            body,
            query);
    end
  
    # マッチメイキングを取得
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    # @return [Array]
    #   * item
    #     * matchmakingId => マッチメイキングID
    #     * ownerId => オーナーID
    #     * name => マッチメイキング名
    #     * description => 説明文
    #     * type => 種類
    #     * maxPlayer => 最大プレイヤー数
    #     * serviceClass => サービスクラス
    #     * callback => コールバックURL
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def get_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Matchmaking',
          'GetMatchmaking',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'],
          query);
    end
  
    # マッチメイキングの状態を取得
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    # @return [Array]
    #   * status => 状態
    def get_matchmaking_status(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Matchmaking',
          'GetMatchmakingStatus',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + '/status',
          query);
    end
    
    # マッチメイキングを更新
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * description => 説明文
    #   * serviceClass => サービスクラス
    #   * callback => コールバックURL
    # @return [Array]
    #   * item
    #     * matchmakingId => マッチメイキングID
    #     * ownerId => オーナーID
    #     * name => マッチメイキング名
    #     * description => 説明文
    #     * type => 種類
    #     * maxPlayer => 最大プレイヤー数
    #     * serviceClass => サービスクラス
    #     * callback => コールバックURL
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def update_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('serviceClass'); body['serviceClass'] = request['serviceClass']; end
      if request.has_key?('callback'); body['callback'] = request['callback']; end
      query = {}
      return put(
          'Gs2Matchmaking',
          'UpdateMatchmaking',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'],
          body,
          query);
    end

    # マッチメイキングを削除
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    def delete_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Matchmaking', 
            'DeleteMatchmaking', 
            @@ENDPOINT, 
            '/matchmaking/' + request['matchmakingName'],
            query);
    end

    # Anybodyマッチメイキング - マッチメイキングを実行<br>
    # <br>
    # Anybodyマッチメイキングのマッチメイキングプロセスは、このAPIを呼び出すことで完結します。<br>
    # このAPIを呼び出した段階で参加者を待っているギャザリングが存在すれば参加し、<br>
    # 参加者を待っているギャザリングが存在しなければ、新しくギャザリングに作成して、そのギャザリングに参加します。<br>
    # <br>
    # 戻り値にはギャザリングに参加している人数が含まれますので、自分がギャザリングを作成したのかはそこで確認することができます。<br>
    # <br>
    # マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#anybody_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#anybody_leave_gathering} を呼び出すことで中断できます。<br>
    # GS2-Matchmaking にはホストという明確な役割は存在しないため、ギャザリングを作成したユーザがマッチメイキングを中断したとしてもマッチメイキングは継続されます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * updateAt => 更新日時
    def anybody_do_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'DoMatchmaking',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/anybody",
          body,
          query,
          header);
    end

    # Anybodyマッチメイキング - ギャザリングに参加しているユーザID一覧取得を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * items => 参加ユーザID一覧
    def anybody_describe_joined_user(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Matchmaking',
          'DescribeJoinedUser',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/anybody/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # Anybodyマッチメイキング - ギャザリングからの離脱を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def anybody_leave_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      delete(
          'Gs2Matchmaking',
          'LeaveGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/anybody/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # CustomAutoマッチメイキング - <br>
    # <br>
    # CustomAutoマッチメイキングを実行する場合は、基本的にはこのAPIを呼び出すことで完結します。<br>
    # CustomAutoマッチメイキングのリクエストパラメータには、参加対象となるギャザリングの属性値の範囲を指定して行われます。<br>
    # 属性値は最大5個指定することができ、属性値毎に検索する最小値・最大値を指定できます。<br>
    # すべての属性値が希望する範囲内に収まっているギャザリングを見つけた場合はそのギャザリングに参加します。<br>
    # <br>
    # 一定時間内にすべてのギャザリングの検索を終えることができなかった場合は、searchContext というパラメータを応答します。<br>
    # この場合、searchContext を指定して このAPIを再度呼び出すことで、検索を再開することができます。<br>
    # この際に指定する検索条件は以前の searchContext と同じ条件にするようにしてください。<br>
    # 条件が変更されたうえで、searchContext を利用した場合の動作は保証できません。<br>
    # <br>
    # すべてのギャザリングを検索した結果、対象となるギャザリングが存在しなかった場合は、新しくギャザリングを作成し、そのギャザリングに参加します。<br>
    # <br>
    # 戻り値にはギャザリングに参加している人数が含まれますので、自分がギャザリングを作成したのかはそこで確認することができます。<br>
    # <br>
    # マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#custom_auto_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#custom_auto_leave_gathering} を呼び出すことで中断できます。<br>
    # GS2-Matchmaking にはホストという明確な役割は存在しないため、ギャザリングを作成したユーザがマッチメイキングを中断したとしてもマッチメイキングは継続されます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * attribute1 => ギャザリング新規作成時の属性1
    #   * attribute2 => ギャザリング新規作成時の属性2
    #   * attribute3 => ギャザリング新規作成時の属性3
    #   * attribute4 => ギャザリング新規作成時の属性4
    #   * attribute5 => ギャザリング新規作成時の属性5
    #   * searchAttribute1Min => 検索対象ギャザリング属性1の下限
    #   * searchAttribute1Max => 検索対象ギャザリング属性1の上限
    #   * searchAttribute2Min => 検索対象ギャザリング属性2の下限
    #   * searchAttribute2Max => 検索対象ギャザリング属性2の上限
    #   * searchAttribute3Min => 検索対象ギャザリング属性3の下限
    #   * searchAttribute3Max => 検索対象ギャザリング属性3の上限
    #   * searchAttribute4Min => 検索対象ギャザリング属性4の下限
    #   * searchAttribute4Max => 検索対象ギャザリング属性4の上限
    #   * searchAttribute5Min => 検索対象ギャザリング属性5の下限
    #   * searchAttribute5Max => 検索対象ギャザリング属性5の上限
    #   * searchContext => 検索コンテキスト
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * done => 検索が完了したか
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * updateAt => 更新日時
    #   * searchContext => 検索コンテキスト
    def custom_auto_do_matchmaking(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('attribute1'); body['attribute1'] = request['attribute1']; end
      if request.has_key?('attribute2'); body['attribute2'] = request['attribute2']; end
      if request.has_key?('attribute3'); body['attribute3'] = request['attribute3']; end
      if request.has_key?('attribute4'); body['attribute4'] = request['attribute4']; end
      if request.has_key?('attribute5'); body['attribute5'] = request['attribute5']; end
      if request.has_key?('searchAttribute1Min'); body['searchAttribute1Min'] = request['searchAttribute1Min']; end
      if request.has_key?('searchAttribute2Min'); body['searchAttribute2Min'] = request['searchAttribute2Min']; end
      if request.has_key?('searchAttribute3Min'); body['searchAttribute3Min'] = request['searchAttribute3Min']; end
      if request.has_key?('searchAttribute4Min'); body['searchAttribute4Min'] = request['searchAttribute4Min']; end
      if request.has_key?('searchAttribute5Min'); body['searchAttribute5Min'] = request['searchAttribute5Min']; end
      if request.has_key?('searchAttribute1Max'); body['searchAttribute1Max'] = request['searchAttribute1Max']; end
      if request.has_key?('searchAttribute2Max'); body['searchAttribute2Max'] = request['searchAttribute2Max']; end
      if request.has_key?('searchAttribute3Max'); body['searchAttribute3Max'] = request['searchAttribute3Max']; end
      if request.has_key?('searchAttribute4Max'); body['searchAttribute4Max'] = request['searchAttribute4Max']; end
      if request.has_key?('searchAttribute5Max'); body['searchAttribute5Max'] = request['searchAttribute5Max']; end
      if request.has_key?('searchContext'); body['searchContext'] = request['searchContext']; end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'DoMatchmaking',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/customauto",
          body,
          query,
          header);
    end

    # CustomAutoマッチメイキング - ギャザリングに参加しているユーザID一覧取得を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * items => 参加ユーザID一覧
    def custom_auto_describe_joined_user(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Matchmaking',
          'DescribeJoinedUser',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/customauto/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # CustomAutoマッチメイキング - ギャザリングからの離脱を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def custom_auto_leave_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return delete(
          'Gs2Matchmaking',
          'LeaveGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/customauto/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # Passcodeマッチメイキング - ギャザリングを作成<br>
    # <br>
    # Passcodeマッチメイキングの開始手段は2つに別れます。<br>
    # ひとつ目は既存のギャザリングに参加すること。もう一つはこのAPIで実行できる、新しくギャザリングを作成する。という手段です。<br>
    # <br>
    # ギャザリングを新しく作成するにあたって必要なパラメータなどはありません。<br>
    # このAPIを呼び出すことでギャザリングが新しく作られ、ギャザリングには固有のパスコード(8ケタ数字)が割り当てられます。<br>
    # 割り当てられたパスコードは戻り値に含まれています。<br>
    # <br>
    # パスコードの上位は乱数、下位はミリ秒単位のタイムスタンプで構成されています。<br>
    # そのため、非常に短い間隔でリクエストを出した時に、乱数もあるため可能性は低くいですがパスコードが衝突する可能性があります。<br>
    # その場合はパスコードを入力した時に同一パスコードを持つギャザリングのうちどのギャザリングに参加するかは不定です。<br>
    # <br>
    # 万全を期するには、ミリ秒単位でルームの作成が多数衝突する頻度でギャザリングを作成する必要がある場合は、<br>
    # Anybody や CustomAuto といった方法のマッチメイキングも併用していただき、友達同士と遊びたい場合にのみ Passcode 方式を利用するよう誘導いただくのが得策です。<br>
    # <br>
    # ギャザリング作成後は、マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#passcode_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#passcode_leave_gathering} を呼び出すことで中断できます。<br>
    # GS2-Matchmaking にはホストという明確な役割は存在しないため、ギャザリングを作成したユーザがマッチメイキングを中断したとしてもマッチメイキングは継続されます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * passcode => ギャザリング参加用パスコード
    #     * updateAt => 更新日時
    def passcode_create_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'CreateGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode",
          body,
          query,
          header);
    end

    # Passcodeマッチメイキング - ギャザリングに参加<br>
    # <br>
    # Passcodeマッチメイキングの開始手段は2つに別れます。<br>
    # ひとつ目は新しくギャザリングを作成すること。もう一つはこのAPIで実行できる、既存のギャザリングに参加する。という手段です。<br>
    # <br>
    # パスコードの交換方法は GS2 では提供しません。<br>
    # ソーシャル連携などの手段は各ゲームで実装頂く必要があります。<br>
    # <br>
    # 何らかの手段で得たパスコードを指定してこのAPIを呼び出すことで、既存のギャザリングに参加することができます。<br>
    # <br>
    # ギャザリング参加後は、マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#passcode_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#passcode_leave_gathering} を呼び出すことで中断できます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * passcode => ギャザリング参加用パスコード
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * passcode => ギャザリング参加用パスコード
    #     * updateAt => 更新日時
    def passcode_join_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('passcode'); raise ArgumentError.new(); end
      if not request['passcode']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'JoinGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode/join/" + request['passcode'],
          body,
          query,
          header);
    end

    # Passcodeマッチメイキング - ギャザリングに参加しているユーザID一覧取得を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * items => 参加ユーザID一覧
    def passcode_describe_joined_user(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Matchmaking',
          'DescribeJoinedUser',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # Passcodeマッチメイキング - ギャザリングからの離脱を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def passcode_leave_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return delete(
          'Gs2Matchmaking',
          'LeaveGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode/" + request['gatheringId'] + "/player",
          query,
          header);
    end
 
    # Passcodeマッチメイキング - ギャザリングの解散を実行。<br>
    # <br>
    # ギャザリングへのプレイヤー募集を中止し、解散します。<br>
    # 解散によって完了コールバックが返ることはありません。<br>
    # この操作はギャザリングの作成主のユーザのみ行うことができます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def passcode_breakup_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return delete(
          'Gs2Matchmaking',
          'BreakupGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode/" + request['gatheringId'],
          query,
          header);
    end

    # Passcodeマッチメイキング - ギャザリングの早期終了を実行。<br>
    # <br>
    # ギャザリングへのプレイヤー募集を早期終了します。<br>
    # Matchmaking で定義した規定人数に満ていない場合もマッチメイキング完了コールバックが返ります。<br>
    # この操作はギャザリングの作成主のユーザのみ行うことができます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def passcode_early_complete_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'EarlyCompleteGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/passcode/" + request['gatheringId'] + "/complete",
          body,
          query,
          header);
    end
    
    # Roomマッチメイキング - ギャザリングを作成<br>
    # <br>
    # Room 方式のマッチメイキングは以下のプロセスで成立します。<br>
    # 
    # 1. {#room_create_gathering} でギャザリングを作成
    # 2. {#room_describe_gathering} でギャザリング一覧を取得
    # 3. 気に入ったルームが見つかったら {#room_join_gathering} でギャザリングに参加
    # 
    # このAPIでは1番目のプロセスのギャザリングの作成が行えます。<br>
    # <br>
    # ギャザリングの作成リクエストには、128バイト以下と非常に小さいですが、ギャザリングのメタ情報を付加することができます。<br>
    # ここにはホストが遊びたいと思っているゲームモードなどの情報を付与し、ギャザリング一覧での表示に利用できます。<br>
    # 129バイト以上のデータを利用したい場合はメタデータのURLを格納するなどして対処してください。<br>
    # <br>
    # ギャザリング作成後、マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#room_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#room_leave_gathering} を呼び出すことで中断できます。<br>
    # GS2-Matchmaking にはホストという明確な役割は存在しないため、ギャザリングを作成したユーザがマッチメイキングを中断したとしてもマッチメイキングは継続されます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * meta => メタデータ(Optional)
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * meta => メタデータ
    #     * updateAt => 更新日時
    def room_create_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('meta'); body['meta'] = request['meta']; end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'CreateGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room",
          body,
          query,
          header);
    end

    # Roomマッチメイキング - ギャザリングに参加<br>
    # <br>
    # Room 方式のマッチメイキングは以下のプロセスで成立します。<br>
    # 
    # 1. {#room_create_gathering} でギャザリングを作成
    # 2. {#room_describe_gathering} でギャザリング一覧を取得
    # 3. 気に入ったルームが見つかったら {#room_join_gathering} でギャザリングに参加
    # 
    # <br>
    # このAPIでは3番目のプロセスのギャザリングへの参加が行えます。<br>
    # ギャザリングの一覧取得からギャザリングへの参加がアトミックに行われるわけではないので、<br>
    # このAPIを呼び出した段階では、ギャザリングが解散していたり、すでに満員になっている可能性があります。<br>
    # そのような場合は、このAPIはエラー応答として、Gs2::Core::BadRequestException 例外をスローします。<br>
    # <br>
    # ギャザリング参加後、マッチメイキング完了コールバックをが返るまで待つことでマッチメイキングの完了を待つことができます。<br>
    # マッチメイキングの進捗を確認したい場合は {#room_describe_joined_user} を呼び出すことで、<br>
    # ギャザリングに参加しているユーザIDが取得できるため、誰とマッチメイキングが行われているか途中経過を取得できます。<br>
    # <br>
    # ユーザ操作などにより、マッチメイキングを中断する場合は {#room_leave_gathering} を呼び出すことで中断できます。<br>
    # <br>
    # ゲーム利用者にとって、最もニーズに合ったギャザリングに参加できるのが Room 方式のマッチメイキングの特徴ではありますが、<br>
    # プレイヤー数が多いゲームにおいては、このアトミックに操作が行われないという点がUXにマイナスの影響をおよぼす可能性があります。<br>
    # どうしても Room 方式でなければならない理由がないのであれば、他のマッチメイキング方式を採用することをおすすめします。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * joinPlayer => 参加プレイヤー数
    #     * meta => メタデータ
    #     * updateAt => 更新日時
    def room_join_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'JoinGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/" + request['gatheringId'],
          body,
          query,
          header);
    end

    # Roomマッチメイキング - ギャザリング一覧を取得<br>
    # <br>
    # Room 方式のマッチメイキングは以下のプロセスで成立します。<br>
    # 
    # 1. {#room_create_gathering} でギャザリングを作成
    # 2. {#room_describe_gathering} でギャザリング一覧を取得
    # 3. 気に入ったルームが見つかったら {#room_join_gathering} でギャザリングに参加
    # 
    # <br>
    # このAPIでは2番目のプロセスのギャザリング一覧の取得が行えます。<br>
    # <br>
    # ギャザリングの一覧をユーザに提供し、気に入ったギャザリングがあれば次のプロセスへ<br>
    # 見つからなければ、先頭から取り直すか戻り値に含まれる nextPageToken を利用して次のページを案内できます。<br>
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * accessToken => アクセストークン
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * gatheringId => ギャザリングID
    #       * joinPlayer => 参加プレイヤー数
    #       * meta => メタデータ
    #       * updateAt => 更新日時
    #   * nextPageToken => 次ページトークン
    def room_describe_gathering(request, pageToken = nil, limit = nil)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Matchmaking',
          'DescribeGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/",
          query,
          header);
    end

    # Roomマッチメイキング - ギャザリングに参加しているユーザID一覧取得を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * items => 参加ユーザID一覧
    def room_describe_joined_user(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Matchmaking',
          'DescribeJoinedUser',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/" + request['gatheringId'] + "/player",
          query,
          header);
    end
    
    # Roomマッチメイキング - ギャザリングからの離脱を実行<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def room_leave_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return delete(
          'Gs2Matchmaking',
          'LeaveGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/" + request['gatheringId'] + "/player",
          query,
          header);
    end

    # Roomマッチメイキング - ギャザリングの解散を実行。<br>
    # <br>
    # ギャザリングへのプレイヤー募集を中止し、解散します。<br>
    # 解散によって完了コールバックが返ることはありません。<br>
    # この操作はギャザリングの作成主のユーザのみ行うことができます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def room_breakup_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return delete(
          'Gs2Matchmaking',
          'BreakupGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/" + request['gatheringId'],
          query,
          header);
    end
 
    # Roomマッチメイキング - ギャザリングの早期終了を実行。<br>
    # <br>
    # ギャザリングへのプレイヤー募集を早期終了します。<br>
    # Matchmaking で定義した規定人数に満ていない場合もマッチメイキング完了コールバックが返ります。<br>
    # この操作はギャザリングの作成主のユーザのみ行うことができます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    #
    # @param request [Array]
    #   * matchmakingName => マッチメイキング名
    #   * gatheringId => ギャザリングID
    #   * accessToken => アクセストークン
    def room_early_complete_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('matchmakingName'); raise ArgumentError.new(); end
      if not request['matchmakingName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringId'); raise ArgumentError.new(); end
      if not request['gatheringId']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Matchmaking',
          'EarlyCompleteGathering',
          @@ENDPOINT,
          '/matchmaking/' + request['matchmakingName'] + "/room/" + request['gatheringId'] + "/complete",
          body,
          query,
          header);
    end
    
  end
end end